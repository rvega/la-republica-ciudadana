class UsuariosController < ApplicationController
  load_and_authorize_resource

  public

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @usuario = Usuario.find(params[:id])

    @participacion = params[:participacion]
    if @participacion=='respuestas'
      @verbo = 'respondido ninguna pregunta'
      @preguntas = []
      @usuario.respuestas.each do |r|
        @preguntas << r.pregunta
      end


    elsif @participacion=='comentarios'
      @verbo = 'publicado ningun comentario'
      @preguntas = []
      @usuario.comentarios.each do |r|
        comentable = r.comentable
        if comentable.class.name == 'Pregunta'
          @preguntas << comentable
        elsif comentable.class.name == 'Respuesta'
          resp = comentable.pregunta
          @preguntas << resp
        end
      end
      @preguntas.uniq!


    elsif @participacion=='votos'
      @verbo = 'votado por ninguna pregunta ni respuesta'
      @preguntas = []
      @usuario.votos.each do |r|
        votable = r.votable
        if votable.class.name == 'Pregunta'
          @preguntas << votable
        elsif votable.class.name == 'Respuesta'
          resp = votable.pregunta
          @preguntas << resp
        end
      end
      @preguntas.uniq!


    else
      @verbo = 'formulado ninguna pregunta'
      @participacion = 'preguntas'
      @preguntas = @usuario.preguntas
    end

    @preguntas.select! {|p| not p.extrana }

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(params[:usuario])
    @usuario.usuario_id = current_usuario.id

    respond_to do |format|
      if @usuario.save
        format.html { redirect_to @usuario }
        format.json { render json: @usuario, status: :created, location: @usuario }
      else
        format.html { render action: "new" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.json
  def update
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        format.html { redirect_to @usuario }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /usuarios/1.json
  def destroy
    pwd = params.delete(:current_password)
    @usuario = current_usuario

    # pwd ok?
    unless @usuario.valid_password?(pwd)
      head :unauthorized
      return
    end

    # motivo present?
    if params[:motivo].nil? or params[:motivo].size < 15
      head :unprocessable_entity
      return
    end 

    # mark user as inactive and logout
    @usuario.disabled = true
    @usuario.save
    sign_out(@usuario)

    # TODO:
    # desactivar/borrar el contenido de este usuario

    # send email to admin
    AdminMailer.deleted_perfil(@usuario, params[:motivo]).deliver

    head :no_content
  end
end
