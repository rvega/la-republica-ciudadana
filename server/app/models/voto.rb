class Voto < ActiveRecord::Base
  attr_accessible :usuario_id, :value
  belongs_to :usuario
  belongs_to :votable, :polymorphic=>true
end
