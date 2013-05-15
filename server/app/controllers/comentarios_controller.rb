class ComentariosController < ApplicationController
  load_and_authorize_resource

  before_filter :find_pregunta_id, :except=>:destroy
  protected
  def find_pregunta_id
    type = params[:comentario][:comentable_type]
    id = params[:comentario][:comentable_id]
    if type=='Pregunta'
      @pid = params[:comentario][:comentable_id]
    elsif type=='Respuesta'
      respuesta = Respuesta.find(id)
      @pid = respuesta.pregunta_id
    end
    
  end

  public 
  
  # POST /comentarios
  # POST /comentarios.json
  def create
    # Crear nuevo comentario
    @comentario = Comentario.new(params[:comentario])

    # Asociarlo con el usuario
    @comentario.usuario_id = current_usuario.id

    # Asociarlo con la Pregunta o Respuesta
    comentable_type = params[:comentario][:comentable_type]
    comentable_id = params[:comentario][:comentable_id]
    if comentable_type=='Pregunta'
      @comentario.comentable = Pregunta.find(comentable_id)
    else
      @comentario.comentable = Respuesta.find(comentable_id)
    end

    respond_to do |format|
      if @comentario.save
        format.html do 
          redirect_to pregunta_url(@pid, :anchor => "comentario_#{@comentario.id}")
        end
        format.json { render json: @comentario, status: :created, location: @comentario }
      else
        format.html do 
          @respuesta = Respuesta.new
          @pregunta = Pregunta.find(@pid)
          render template: "preguntas/show"
        end
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comentarios/1
  # PUT /comentarios/1.json
  def update
    @comentario = Comentario.find(params[:id])

    respond_to do |format|
      if @comentario.update_attributes(params[:comentario])
        format.html do 
          redirect_to pregunta_url(@pid, :anchor => "comentario-#{@comentario.id}")
        end
        format.json { head :no_content }
      else
        format.html do
          @editing_comentario = true
          @pregunta = Pregunta.find(@pid)
          render template: "preguntas/show" 
        end
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentarios/1.json
  def destroy
    @comentario = Comentario.find(params[:id])
    @comentario.disabled = true
    @comentario.save

    head :no_content
  end

end
