class Respuesta < ActiveRecord::Base
  has_paper_trail

  include Mixins::Votable

  attr_accessible :cuerpo, :usuario_id, :pregunta_id

  validates :cuerpo, :length => { :in => 15..30000 }

  validate :only_one_respuesta_per_pregunta, :on=>:create
  def only_one_respuesta_per_pregunta
    r = Respuesta.where("pregunta_id=? AND usuario_id=?", self.pregunta_id, self.usuario_id).count
    if r>0
      errors.add(:usuario_id, "Usted ya ha ingresado una respuesta para esta pregunta.")
    end
  end

  has_many :comentarios, :as=>:comentable
  has_many :votos, :as=>:votable
  belongs_to :usuario
  belongs_to :pregunta

  include Mixins::HtmlCleaner
  before_validation do |respuesta|
    respuesta.cuerpo = clean(respuesta.cuerpo)     
  end

  after_create :update_score
  def update_score
    p = Pregunta.find self.pregunta_id 
    p.calculate_score
  end
end

