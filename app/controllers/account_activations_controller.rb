class AccountActivationsController < ApplicationController
def new
end
def create
@user = User.find_by(email: params[:account_activation][:email].downcase)
if @user && !@user.activated?
@user.re_send_activation_email
flash[:success] = t(:flash_users_activate)
render :new
else
flash.now[:error] = t(:flash_users_activate_error)
render :new
end
end

def edit
user = User.find_by(email: params[:email])
#finding the user with the email params from the link in the email
if user && !user.activated? && user.authenticated?(:activation, params[:id])
user.activate
sign_in user
flash[:success] = t(:accounts_activation_success)
redirect_to user
else
flash[:error] = t(:accounts_activation_link_error)
redirect_to signin_url
end
end
end

