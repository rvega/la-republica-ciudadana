class RegistrationsController < Devise::RegistrationsController
  protected
  def after_update_path_for(resource)
    usuario_path(resource)
  end

  public
  def new
    # if request came from this server, redirect there after registering in.
    r = URI.parse(request.referer)
    if r.host==request.host and not request.referer==request.url and not r.path==new_usuario_session_path
      session[:usuario_return_to] = request.referer
    end
    super
  end

  # def update
  #   super 

  #   # dont't show "updated" notice
  #   prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
  #   if is_navigational_format? and not update_needs_confirmation?(resource, prev_unconfirmed_email)
  #     flash[:notice] = nil
  #   end
  # end
end
