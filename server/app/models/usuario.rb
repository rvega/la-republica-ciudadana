class Usuario < ActiveRecord::Base
  has_paper_trail

  # Include default devise modules. Others available are:
  # :token_authenticatable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :nombre, :descripcion, :acepta_terminos
  has_many :comentarios
  has_many :preguntas
  has_many :respuestas
  has_many :votos

  validates :nombre, :presence=>true
  validates :acepta_terminos, :acceptance=>{:accept=>true}, :on => :create
end
