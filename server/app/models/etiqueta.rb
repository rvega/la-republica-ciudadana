class Etiqueta < ActiveRecord::Base
  attr_accessible :etiqueta
  has_and_belongs_to_many :pregunta, :uniq=>true

  validates :etiqueta, :uniqueness=>true
end
