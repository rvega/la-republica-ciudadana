class Comentario < ActiveRecord::Base
  attr_accessible :cuerpo
  belongs_to :usuario
end
