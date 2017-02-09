class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
	helper_method :current_user_order
	helper_method :require_login
	helper_method :authorised_user
  
  private
  	
  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

	def current_user_order
		if current_user.pending_order
			current_user.pending_order
    else
      current_user.orders.create
    end
  end

	def require_login
		redirect_to sign_in_path if !current_user			
	end

	def authorised_user
		current_user && current_user.admin ? true : false
	end	
	
end
