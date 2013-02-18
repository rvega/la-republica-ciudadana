class Pregunta < ActiveRecord::Base

  attr_accessible :cuerpo, :topico, :etiquetas_list
  has_many :etiquetas
  has_many :votos, :as=>:votable
  has_many :respuestas
  has_many :comentarios, :as=>:comentable

  validates :topico, :length => { :in => 3..150 }
  validates :cuerpo, :length => { :in => 15..30000 }
  validates :etiquetas_list, :presence=>true

  include Mixins::HtmlCleaner
  before_validation do |pregunta|
    pregunta.cuerpo = clean(pregunta.cuerpo)     
  end

  def etiquetas_list=(new_value)
    etiquetas_names = new_value.split(',')
    self.etiquetas = etiquetas_names.map do |name| 
      Etiqueta.where('etiqueta=?', name.strip).first or Etiqueta.create(:etiqueta => name.strip)
    end
  end

  def etiquetas_list
    self.etiquetas.map {|e| e.etiqueta}.join(',')
  end
end
