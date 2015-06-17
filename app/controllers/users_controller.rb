class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers, :mijn_vacatures]
  before_action :correct_user,   only: [:edit, :update, :mijn_vacatures]
  before_action :admin_user,     only: [:destroy, :index]
  
  def index
    @users = User.page(params[:page]).per(15)
  end
  
	def show
		@user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(15)
	end

 	def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
      flash[:success] = t(:flash_users_activate)
  		redirect_to signin_url
  	else
      flash.now[:error] = @user.errors.full_messages.to_sentence
  		render 'new'  
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t(:flash_users_update)
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.stripe_customer_id?
      customer = Stripe::Customer.retrieve(user.stripe_customer_id).delete
    end
    user.destroy
    flash[:success] = t(:flash_users_delete)
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def mijn_vacatures
    @user = current_user
    @subscriptions = @user.subscriptions.state_finished
    @jobs = @user.jobs
    @free_jobs = @user.jobs.where(free: true)
    # free_jobs where free == true
    # @card = Stripe::Customer.retrieve(@user.stripe_customer_id).cards   
  end

  def update_card
  end

  # def delete_card
  #   user = current_user
  #   customer = Stripe::Customer.retrieve(user.stripe_customer_id)
  #   if customer.sources.retrieve(customer.default_source).delete
  #    redirect_to mijn_vacatures_user_path(user)
  #    flash[:success] = "Credit card verwijderd"
  #   end
  # end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, 
  									 :password_confirmation, :avatar, :university)
  	end
    #before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  end

