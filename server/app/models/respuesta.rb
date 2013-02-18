class Respuesta < ActiveRecord::Base
  include Mixins::Votable

  attr_accessible :cuerpo, :usuario_id, :pregunta_id

  validates :cuerpo, :length => { :in => 15..30000 }
  # TODO: validate user enters only one answer to a question, do this after implementing edit pregunta

  has_many :comentarios, :as=>:comentable
  has_many :votos, :as=>:votable

  include Mixins::HtmlCleaner
  before_validation do |respuesta|
    respuesta.cuerpo = clean(respuesta.cuerpo)     
  end
end

