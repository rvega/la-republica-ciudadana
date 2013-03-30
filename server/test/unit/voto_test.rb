require 'test_helper'
require 'debugger'

class VotoTest < ActiveSupport::TestCase
  test "should update the user's score" do
    user = usuarios(:rafa)
    score = user.puntaje
    votable = Pregunta.create({
      :cuerpo => preguntas(:uno).cuerpo,
      :topico => preguntas(:uno).topico,
      :etiquetas_list => %{label1, label2}
    })
    votable_type = 'Pregunta'
    @voto = Voto.create!({
      :value => 1,
      :usuario_id => user.id,
      :votable_type => votable_type,
      :votable_id => votable.id
    })

    user.reload

    assert_not_equal score, user.puntaje
  end
end
