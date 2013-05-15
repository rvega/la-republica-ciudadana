# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


class Usuario < ActiveRecord::Base
  attr_accessible :id, :rol, :confirmed_at
end

class Pregunta < ActiveRecord::Base
  attr_accessible :id, :usuario_id, :extrana, :topico, :cuerpo, :score
end


if Usuario.find_by_id(1).nil?
  Usuario.create :id=>1, 
    :nombre=>"Admin", 
    :email=>"admin@admin.com", 
    :password=>"lalala121212", 
    :password_confirmation=>"lalala121212", 
    :rol=>'admin',
    :confirmed_at => DateTime.new
end

if Pregunta.find_by_id(1).nil?
  Pregunta.create :id=>1,
    :topico=>"¿Cómo podemos mejorar la aplicación de La República Ciudadana?",
    :cuerpo=>"Esta pregunta está claramente fuera de tópico pero la quisimos incluir para poder preguntarles a ustedes, los usuarios, que sugerencias o críticas tienen para nuestra aplicación. <br><br>Animense a participar y gracias por ayudarnos a mejorar!",
    :usuario_id=>1,
    :extrana=>1,
    :score=>0
end
