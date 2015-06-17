class SessionsController < ApplicationController
	before_action :signed_in_user_check, only: [:new]
	
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			if user.activated?
				#sign in only when the account is activated
				sign_in user
			    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
			    #if params remember me == 1 then remember user, else forget user
			    redirect_back_or root_url
			else
				flash[:notice] = t(:accounts_activation_error)
				redirect_to signin_url
			end
		else
			flash.now[:error] = t(:flash_sessions_error)
			render 'new'
		end
	end


	def destroy
		sign_out if signed_in?
		redirect_to root_url
	end

	private 

	def signed_in_user_check
		if signed_in?
			redirect_to root_url
		end
	end
end

