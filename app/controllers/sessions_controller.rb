class SessionsController < ApplicationController

	rescue_from ActiveRecord::RecordNotFound, with: :show_error

	def create
		@user = User.find_by_email params[:id]
		puts @user
		if @user && @user.authenticate(params[:password])
			flash[:success] = "Successfully logged in"
			session[:user] = @user.id
			redirect_to @user
		else
			show_error
		end		
	end

	def destroy
		session[:user] = nil
		flash[:success] = "Successfully logged out."
		redirect_to root_url
	end
	
	private
	
  def show_error
  	flash.now[:error] = "Invalid email/password"
  	render :new
  end

end
