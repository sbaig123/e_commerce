class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "#{@user.first_name} has successfully signed up"
			redirect_to @user
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
  end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end

end
