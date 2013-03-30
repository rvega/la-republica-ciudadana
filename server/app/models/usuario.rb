class Usuario < ActiveRecord::Base
  has_paper_trail

  # Include default devise modules. Others available are:
  # :token_authenticatable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :nombre, :descripcion
  has_many :comentarios
  has_many :preguntas
  has_many :respuestas
  has_many :votos

  validates :nombre, :presence=>true


  # Puntaje

  # Actualiza el puntaje basado en un voto
  def update_puntaje(vote)
    points = get_puntaje(vote.value, vote.votable_type)
    increment!(:puntaje, points)
  end

  # Actualiza el puntaje basado en todos los votos que el usuario
  # tiene asociado
  def update_puntaje_votos
    points = votable_votes.inject(0) do |points, v|
      points + get_puntaje(v.value, v.votable_type)
    end
    update_attribute(:puntaje, points)
  end

  private

    # Calcula el puntaje para el valor de un voto y un tipo de
    # votable
    def get_puntaje(value, type)
      type = type.downcase
      sign = value < 0 ? "menos" : "mas"
      PUNTAJES_CONFIG["voto_#{type}_#{sign}"]
    end

    # Retorna un arreglo con todos los votos de las preguntas y
    # respuestas
    def votable_votes
      q_votes = preguntas.collect { |q| q.votos }.flatten
      a_votes = respuestas.collect { |a| a.votos }.flatten
      q_votes.concat(a_votes)
    end
end
