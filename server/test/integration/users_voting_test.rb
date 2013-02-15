require 'test_helper'

class UsersVotingTest < ActionDispatch::IntegrationTest
  fixtures :usuarios, :preguntas

  def login_as(usuario)
    get '/usuarios/ingreso'
    assert_response :success

    post_via_redirect '/usuarios/ingreso', 'usuario[email]' => usuario.email, 'usuario[password]' => 'wrong'
    assert_equal '/usuarios/ingreso', path

    post_via_redirect '/usuarios/ingreso', 'usuario[email]' => usuario.email, 'usuario[password]' => '123123123'
    assert_equal '/', path
    assert_equal 'Signed in successfully.', flash[:notice]
  end

  test "Solo un voto por usuario" do
    login_as usuarios(:rafa)
    
    # Votar "mas" a la pregunta numero 1
    # post '/votos', :pregunta_id=>1, :valor=>1

    # Esto no está terminado...
    assert false, 'No he terminado de escribir este test'
  end
end
