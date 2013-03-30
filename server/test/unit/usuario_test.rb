require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  setup do
    @user = usuarios(:rafa)
  end

  # Puntaje tests
  def assert_score_changed(upvote, type)
    value = upvote ? 1 : -1
    suffix = upvote ? "mas" : "menos"
    exp_score = PUNTAJES_CONFIG["voto_#{type.downcase}_#{suffix}"]

    vote = Voto.new({
      :value => value,
      :votable_type => type
    })

    # init puntaje to make assert_difference happy and
    # maintain default db value null
    @user.puntaje = 0
    assert_difference('@user.puntaje', exp_score) do
      @user.update_puntaje(vote)
    end
  end

  test "should compute the score for upvoted pregunta" do
    assert_score_changed(true, 'Pregunta')
  end

  test "should compute the score for upvoted respuesta" do
    assert_score_changed(true, 'Respuesta')
  end

  test "should compute the score for downvoted pregunta" do
    assert_score_changed(false, 'Pregunta')
  end

  test "should compute the score for downvoted respuesta" do
    assert_score_changed(false, 'Respuesta')
  end

  test "should compute the overall score of all votes" do
    exp_score = 5
    @user.update_puntaje_votos
    assert_equal exp_score, @user.puntaje
  end
end
