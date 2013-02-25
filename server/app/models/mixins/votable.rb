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
      previous_votos = Voto.where("usuario_id=? AND votable_id=? AND votable_type=?", usuario_id, self.id, self.class.name).count
      previous_votos > 0
    end
  end
end
