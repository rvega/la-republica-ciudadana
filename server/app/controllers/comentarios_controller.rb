class ComentariosController < ApplicationController
  # POST /comentarios
  # POST /comentarios.json
  def create
    # Pregunta id
    pid = params[:comentario][:pregunta_id]
    params[:comentario].delete(:pregunta_id)

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
          redirect_to pregunta_url(pid, :anchor => "comentario_#{@comentario.id}"),
            notice: 'Comentario was successfully created.'
        end
        format.json { render json: @comentario, status: :created, location: @comentario }
      else
        format.html do 
          @respuesta = Respuesta.new
          @pregunta = Pregunta.find(pid)
          render template: "preguntas/show"
        end
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end
end
