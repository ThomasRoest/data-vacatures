class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end

  def create
  	@user = User.find_by(email: params[:password_reset][:email].downcase)
  	if @user
  		@user.create_reset_digest
  		@user.send_password_reset_email
  		flash[:success] = t(:flash_password_reset_sent)
  		redirect_to root_url
  	else
  		flash.now[:error] = t(:flash_password_reset_notfound)
  		render 'new'
  	end
  end


  def edit
  end

  def update
    if password_blank?
      flash.now[:error] = t(:flash_password_reset_empty)
      render 'edit'
    elsif @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = t(:flash_password_reset_success)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def password_blank?
      #a password blank is currently allowed in the model (for the user edit form), so we 
      #have to catch this explicitly and show a flash message
      params[:user][:password].blank?
    end
    
    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    #check expiration for reset token
    def check_expiration
      if @user.password_reset_expired?
        flash[:error] = t(:flash_password_reset_expired)
        redirect_to new_password_reset_url
      end
    end

end
