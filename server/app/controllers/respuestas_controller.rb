class RespuestasController < ApplicationController
  load_and_authorize_resource 

  # POST /respuestas
  # POST /respuestas.json
  def create
    @respuesta = Respuesta.new(params[:respuesta])
    @respuesta.usuario_id = current_usuario.id

    respond_to do |format|
      if @respuesta.save
        format.html do 
          redirect_to pregunta_url(@respuesta.pregunta_id, :anchor => "respuesta_#{@respuesta.id}")
        end
        format.json { render json: @respuesta, status: :created, location: @respuesta }
      else
        format.html do 
          @comentario = Comentario.new
          @pregunta = Pregunta.find(@respuesta.pregunta_id)
          render template: "preguntas/show"
        end
        format.json { render json: @respuesta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /respuestas/1
  # PUT /respuestas/1.json
  def update
    @respuesta = Respuesta.find(params[:id])

    respond_to do |format|
      if @respuesta.update_attributes(params[:respuesta])
        format.html do 
          redirect_to pregunta_url(@respuesta.pregunta_id, :anchor => "respuesta_#{@respuesta.id}")
        end
        format.json { head :no_content }
      else
        format.html do
          @editing_respuesta = true
          @comentario = Comentario.new
          @pregunta = Pregunta.find(@respuesta.pregunta_id)
          render template: "preguntas/show" 
        end
        format.json { render json: @respuesta.errors, status: :unprocessable_entity }
      end
    end
  end
end
