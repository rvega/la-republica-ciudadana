class Etiqueta < ActiveRecord::Base
  attr_accessible :etiqueta
  belongs_to :pregunta
end
