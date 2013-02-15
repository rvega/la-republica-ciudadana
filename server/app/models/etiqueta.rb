class Etiqueta < ActiveRecord::Base
  attr_accessible :etiqueta
  belongs_to :pregunta

  validates :etiqueta, :uniqueness=>true
end
