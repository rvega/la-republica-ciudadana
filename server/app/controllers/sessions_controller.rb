class SessionsController < Devise::SessionsController
  def new
    # if request came from this server, redirect there after logging in
    if URI.parse(request.referer).host==request.host and not request.referer==request.url
      session[:usuario_return_to] = request.referer
    end
    super
  end
end
