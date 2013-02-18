class Voto < ActiveRecord::Base
  attr_accessible :usuario_id, :value, :votable_type, :votable_id
  belongs_to :usuario
  belongs_to :votable, :polymorphic=>true

  # TODO: implement user can only vote once for a votable
end
