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
  end
end
