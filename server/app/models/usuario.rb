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
  has_many :comentarios, :conditions=> ["disabled = ?", false]
  has_many :preguntas, :conditions=> ["disabled = ?", false]
  has_many :respuestas, :conditions=> ["disabled = ?", false]
  has_many :votos

  validates :nombre, :presence=>true
  validates :acepta_terminos, :acceptance=>{:accept=>true}, :on => :create

  def valid_password?(password)
    return false if encrypted_password.blank?
    bcrypt   = ::BCrypt::Password.new(encrypted_password)
    password = ::BCrypt::Engine.hash_secret("#{password}#{self.class.pepper}", bcrypt.salt)
    Devise.secure_compare(password, encrypted_password)
  end

  def active_for_authentication?
    super and not disabled
  end
end
