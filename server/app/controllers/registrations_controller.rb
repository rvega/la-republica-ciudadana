class RegistrationsController < Devise::RegistrationsController
  def new
    # if request came from this server, redirect there after registering in.
    r = URI.parse(request.referer)
    if r.host==request.host and not request.referer==request.url and not r.path==new_usuario_session_path
      session[:usuario_return_to] = request.referer
    end
    super
  end
end
