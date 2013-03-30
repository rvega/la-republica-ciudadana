require 'test_helper'
require 'debugger'

class VotoTest < ActiveSupport::TestCase
  test "should update the user's score" do
    user = usuarios(:rafa)
    user.update_puntaje_votos()
    voter = usuarios(:fanny)
    score = user.puntaje

    # Create a votable
    votable = Pregunta.new({
      :cuerpo => preguntas(:uno).cuerpo,
      :topico => preguntas(:uno).topico,
      :etiquetas_list => %{label1, label2}
    })
    votable.usuario_id = user.id
    votable.save

    # Vote for it
    votable_type = 'Pregunta'
    @voto = Voto.create!({
      :value => 1,
      :usuario_id => voter.id,
      :votable_type => votable_type,
      :votable_id => votable.id
    })

    user.reload

    assert score < user.puntaje, "New 'puntaje' #{score} must be greater than the previous #{user.puntaje}"
  end

  test "should revert the user's score" do
    user = usuarios(:rafa)
    user.update_puntaje_votos()
    score = user.puntaje
    votos(:two).destroy()
    user.reload
    assert score > user.puntaje, "New 'puntaje' #{score} must be less than the previous #{user.puntaje}"
  end
end
