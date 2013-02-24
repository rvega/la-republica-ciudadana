class Comentario < ActiveRecord::Base
  has_paper_trail

  attr_accessible :cuerpo, :usuario_id, :comentable_id, :comentable_type

  validates :cuerpo, :length => { :in => 15..300 }

  belongs_to :usuario
  belongs_to :comentable, :polymorphic=>true
end
