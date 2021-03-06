class PreguntasController < ApplicationController
  load_and_authorize_resource

  public

  # GET /preguntas
  # GET /preguntas.json
  def index
    @is_home = true

    s = params[:orden]
    if s=='mas'
      s = 'score ASC'
    elsif s=='menos'
      s = 'score DESC'
    end

    b = params[:busqueda]
    if b.nil? or b.strip.empty?
      @preguntas = Pregunta.includes(:etiquetas)
        .where("extrana=?", false)
        .where("disabled=?", false)
        .paginate(:page => params[:pagina], :per_page=>20)
        .order(s)
    else
      @preguntas = Pregunta.joins(:etiquetas)
        .where("etiquetas.etiqueta=? OR preguntas.topico LIKE ? OR preguntas.cuerpo LIKE ?", b, "%#{b}%", "%#{b}%") 
        .where("extrana=?", false)
        .where("disabled=?", false)
        .uniq
        .paginate(:page => params[:pagina], :per_page=>20)
        .order('created_at DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @preguntas }
    end
  end

  # GET /preguntas/1
  # GET /preguntas/1.json
  def show
    @pregunta = Pregunta.find(params[:id])
      
    if @pregunta.disabled or @pregunta.nil?
      raise ActionController::RoutingError.new('Not Found')
      return
    end

    @respuesta = Respuesta.new
    @comentario = Comentario.new
    @title = @pregunta.topico

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pregunta }
    end
  end

  # GET /preguntas/new
  # GET /preguntas/new.json
  def new
    @pregunta = Pregunta.new
    @title = 'Nueva Pregunta'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pregunta }
    end
  end

  # GET /preguntas/1/edit
  def edit
    @pregunta = Pregunta.find(params[:id])
  end

  # POST /preguntas
  # POST /preguntas.json
  def create
    @pregunta = Pregunta.new(params[:pregunta])
    @pregunta.usuario_id = current_usuario.id

    respond_to do |format|
      if @pregunta.save
        format.html { redirect_to @pregunta }
        format.json { render json: @pregunta, status: :created, location: @pregunta }
      else
        format.html { render action: "new" }
        format.json { render json: @pregunta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /preguntas/1
  # PUT /preguntas/1.json
  def update
    @pregunta = Pregunta.find(params[:id])

    respond_to do |format|
      if @pregunta.update_attributes(params[:pregunta])
        format.html { redirect_to @pregunta }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pregunta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preguntas/1.json
  def destroy
    pwd = params.delete(:current_password)
    usuario = current_usuario

    # pwd ok?
    unless usuario.valid_password?(pwd)
      head :unauthorized
      return
    end

    # motivo present?
    if params[:motivo].nil? or params[:motivo].size < 15
      head :unprocessable_entity
      return
    end 

    # mark pregunta as inactive and logout
    @pregunta = Pregunta.find(params[:id])
    @pregunta.disabled = true
    @pregunta.save

    # TODO:
    # desactivar/borrar las respuestas y votos de esta pregunta

    # send email to admin
    AdminMailer.deleted_pregunta(@pregunta, params[:motivo]).deliver

    head :no_content
  end
end
