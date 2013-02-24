class Voto < ActiveRecord::Base
  attr_accessible :usuario_id, :value, :votable_type, :votable_id
  belongs_to :usuario
  belongs_to :votable, :polymorphic=>true

  validate :no_voting_for_self
  def no_voting_for_self
    if self.votable.usuario_id == self.usuario_id
      errors.add(:usuario_id, "No es posible votar por su propia #{self.votable_type.downcase}")
    end
  end

  validate :only_one_vote_per_user
  def only_one_vote_per_user
    if self.votable.ya_voto?(self.usuario_id)
      errors.add(:usuario_id, "Usted ya ha votado por esta #{self.votable_type.downcase}")
    end
  end
end
