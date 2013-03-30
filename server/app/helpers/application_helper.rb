module ApplicationHelper
  def scored_username(user)
    score = "(#{user.puntaje})" unless user.puntaje.nil?
    "#{user.nombre} #{score}"
  end
end
