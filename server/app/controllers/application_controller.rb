class ApplicationController < ActionController::Base
  protect_from_forgery

  def user_for_paper_trail 
    current_usuario
  end
end
