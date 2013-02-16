class PreguntasController < ApplicationController
  layout :choose_layout

  private
  def choose_layout
    case action_name
    when "index"
      "home"
    else
      "application"
    end
  end

  public

  # GET /preguntas
  # GET /preguntas.json
  def index
    @preguntas = Pregunta.includes(:etiquetas)
      .paginate(:page => params[:pagina], :per_page=>20)
      .order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @preguntas }
    end
  end

  # GET /preguntas/1
  # GET /preguntas/1.json
  def show
    @pregunta = Pregunta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pregunta }
    end
  end

  # GET /preguntas/new
  # GET /preguntas/new.json
  def new
    @pregunta = Pregunta.new

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
    # Clean html input
    @pregunta = Pregunta.new(params[:pregunta])

    respond_to do |format|
      if @pregunta.save
        format.html { redirect_to @pregunta, notice: 'Pregunta was successfully created.' }
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
        format.html { redirect_to @pregunta, notice: 'Pregunta was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pregunta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preguntas/1
  # DELETE /preguntas/1.json
  def destroy
    @pregunta = Pregunta.find(params[:id])
    @pregunta.destroy

    respond_to do |format|
      format.html { redirect_to preguntas_url }
      format.json { head :no_content }
    end
  end
end
