#encoding: utf-8 

class AdminMailer < ActionMailer::Base
  default from: "no-reply@larepublicaciudadana.co"

  def deleted_pregunta(pregunta, motivo)
    @pregunta = pregunta
    @motivo = motivo
    mail(:to => 'info@larepublicaciudadana.co', :subject => 'Alguien borró una pregunta en Repciu' )
  end

  def deleted_perfil(usuario, motivo)
    @usuario = usuario
    @motivo = motivo
    mail(:to => 'info@larepublicaciudadana.co', :subject => 'Alguien borró su perfil en Repciu' )
  end
end
