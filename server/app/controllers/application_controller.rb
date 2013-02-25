class ApplicationController < ActionController::Base
  protect_from_forgery

  # Pass the correct usuario object to paper_trail (gem that does edit history)
  def user_for_paper_trail 
    current_usuario
  end

  # Redirect the user to wherever he was before login/registration
  def after_sign_in_path_for(resource)
    (session[:usuario_return_to].nil?) ? "/" : session[:usuario_return_to].to_s
  end

  # Show pretty error when user doesn't have permissions
  rescue_from CanCan::AccessDenied, :with=> :access_denied
  def access_denied(e)
    respond_to do |format|
      msg = "Debe ingresar antes de #{I18n.t e.action} un #{e.subject.class.name.downcase}."
      format.json { render json: {usuario_id:msg}, status: :unauthorized }
      format.html { redirect_to '/', :alert=>msg }
    end
  end

  # Pass the correct usuario object to cancan for authorization
  def current_ability
    @current_ability ||= Ability.new(current_usuario)
  end

  # Check authorization everwhere except for devise and pages controllers
  check_authorization :if => :need_auth?
  private
  def need_auth?
    not (devise_controller? or self.controller_name=='pages')
  end
end
