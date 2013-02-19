#encoding: utf-8

class Voto < ActiveRecord::Base
  attr_accessible :usuario_id, :value, :votable_type, :votable_id
  belongs_to :usuario
  belongs_to :votable, :polymorphic=>true

  # validates :value, :length => {:minimum => 10}
  validate :only_one_vote_per_user

  def only_one_vote_per_user
    previous_votos = Voto.where("usuario_id=? AND votable_id=?", self.usuario_id, self.votable_id).count
    if previous_votos > 0
      errors.add(:usuario_id, "Usted ya ha votado por esta #{self.votable_type.downcase}.")
    end
  end
end
