class ApplicationController < ActionController::Base 
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :reset_session
  #before_action :flash_test
  include SessionsHelper

  def signed_in_user
    unless signed_in?
    	  store_location
        flash[:notice] = t(:flash_errors_signin)
        redirect_to signin_url
      end
  end
end
