class Pregunta < ActiveRecord::Base
  attr_accessible :cuerpo, :topico, :etiquetas_list
  has_many :etiquetas
  
  validates :topico, :length => { :in => 3..150 }
  validates :cuerpo, :length => { :in => 15..30000 }

  def etiquetas_list=(new_value)
    etiquetas_names = new_value.split(',')
    self.etiquetas = etiquetas_names.map do |name| 
      Etiqueta.where('etiqueta=?', name.strip).first or Etiqueta.create(:etiqueta => name.strip)
    end
  end

  def etiquetas_list
    self.etiquetas.map {|e| e.etiqueta}.join(',')
  end

  before_validation :clean_cuerpo_html
  protected
  def clean_cuerpo_html
    elements = %w(b i u blockquote a span br ul li ol)
    attributes = {
      'a' => %w(href title target rel),
      'blockquote' => %w(style), 
      'span' => ['class']
    }
    add_attributes = {'a' => {'rel' => "nofollow"}}
    protocols = {'a' => {'href'=>%w(ftp http https mailto :relative)}}

    self.cuerpo = Sanitize.clean(
      self.cuerpo, 
      :elements => elements, 
      :attributes => attributes, 
      :protocols => protocols,
      :add_attributes => add_attributes
    )
  end
end
