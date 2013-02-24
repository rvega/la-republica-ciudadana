class VotosController < ApplicationController
  # POST /votos
  # POST /votos.json
  def create
    # Crear nuevo voto
    @voto = Voto.new(params[:voto])

    # Asociarlo con el usuario
    @voto.usuario_id = current_usuario.id

    # Asociarlo con la Pregunta o Respuesta
    votable_type = params[:voto][:votable_type]
    votable_id = params[:voto][:votable_id]
    if votable_type=='Pregunta'
      @voto.votable = Pregunta.find(votable_id)
    else
      @voto.votable = Respuesta.find(votable_id)
    end

    respond_to do |format|
      if @voto.save
        resp = {
          :votos_total => @voto.votable.votos_total,
          :votos_menos => @voto.votable.votos_menos,
          :votos_mas => @voto.votable.votos_mas
        }
        format.json { render json: resp, status: :created, location: @voto }
      else
        format.json { render json: @voto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votos
  # DELETE /votos.json
  def destroy
    @voto = Voto.where("usuario_id=? AND votable_id=?", current_usuario.id, params[:voto][:votable_id]).first
    @voto.destroy

    respond_to do |format|
      if params[:voto][:votable_type]=='Pregunta'
        votable = Pregunta.find(params[:voto][:votable_id])
      else
        votable = Respuesta.find(params[:voto][:votable_id])
      end
      resp = {
        :votos_total => votable.votos_total,
        :votos_menos => votable.votos_menos,
        :votos_mas => votable.votos_mas
      }
      format.json { render json: resp, status: :ok }
      format.html { redirect_to votos_url }
    end
  end
end
