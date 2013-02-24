module Mixins
  module Votable
    def votos_total
      votos_mas - votos_menos
    end

    def votos_mas
      self.votos.where('value = +1').count
    end

    def votos_menos
      self.votos.where('value = -1').count
    end

    def ya_voto?(usuario_id)
      previous_votos = Voto.where("usuario_id=? AND votable_id=?", usuario_id, self.id).count
      previous_votos > 0
    end
  end
end
