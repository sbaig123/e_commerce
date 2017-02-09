module RequestSpecHelper

	def sign_in(user)
    request.session[:user] = user.id
  end

  def sign_out
    request.session[:user] = nil
  end

end
