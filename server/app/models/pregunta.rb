class Pregunta < ActiveRecord::Base
  include Mixins::Votable

  attr_accessible :cuerpo, :topico, :etiquetas_list

  belongs_to :usuario
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

  def comentarios_count
    c = self.comentarios.count 
    c2 = 0
    self.respuestas.each do |r|
      c2 = c2 + r.comentarios.count
    end
    c + c2
  end

  def respuestas_count
    self.respuestas.count
  end

  def usuario_already_answered(usuario)
    self.respuestas.where("usuario_id=?", usuario.id).count > 0
  end
end
