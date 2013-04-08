#encoding: UTF-8

class Comentario < ActiveRecord::Base
  has_paper_trail

  attr_accessible :cuerpo, :usuario_id, :comentable_id, :comentable_type

  validates :cuerpo, :length => { :in => 15..300, :message=>"es demasiado corto (mínimo 15 caracteres)" }

  belongs_to :usuario
  belongs_to :comentable, :polymorphic=>true
end
