module SessionsHelper

	def sign_in(user)
		session[:user_id] = user.id
	end
	#check

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
	#remember user

	def current_user?(user)
		user == current_user
	end

	#returns the user corresponding to the remember token cookie
	def current_user
	    if (user_id = session[:user_id])
	      @current_user ||= User.find_by(id: user_id)
	    elsif (user_id = cookies.signed[:user_id])
	      user = User.find_by(id: user_id)
	      if user && user.authenticated?(:remember, cookies[:remember_token])
	        sign_in user
	        @current_user = user
	      end
	    end
    end

	def signed_in?
		!current_user.nil?
	end
	
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def sign_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	def store_location
		session[:forwarding_url] = request.url if request.get?
	end
end

