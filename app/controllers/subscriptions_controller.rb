class SubscriptionsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create, :pickup, :show_sub]
  before_action :load_plans
  before_action :admin_user, only: [:overview, :show_sub]
  before_action :correct_user, only: [:destroy]
  before_action :check_card, only: [:new]
  before_action :check_customer_id, only: [:show_multiple]

 
  def overview
  	@subscriptions = Subscription.page(params[:page]).per(20)
  	#admin dashboard
  end

  def show_sub
     @subscription = Subscription.find(params[:id])
     @sub_job = Job.find_by(guid: @subscription.guid)
     @user = User.find_by(email: @subscription.email)
  end

	def new
		@subscription = Subscription.new
		@plan = Plan.find(params[:plan_id])	
	end

	 def create
      @plan = Plan.find(params[:plan_id])

      unless params[:coupon].blank?
         @subscription = CreateSubscription.call(
           @plan, 
           params[:email], 
           params[:stripeToken],
           params[:coupon]
          )
      else
          @subscription = CreateSubscription.call(
          @plan, 
          params[:email], 
          params[:stripeToken],
          )
      end
        
		 if @subscription.finished?
        flash[:success] = t(:flash_pickup_success)
        redirect_to newjob_url(guid: @subscription.guid)
     else
        errorMessages = {
          "incorrect_number" => "Het creditcardnummer is onjuist",
          "invalid_number" => "Het creditcardnummer is onjuist",
          "invalid_expiry_month" => "De vervaldatum (maand) van de creditcard is onjuist",
          "invalid_expiry_year" => "De vervaldatum (jaar) van de creditcard is onjuist",
          "invalid_cvc" => "De CVC code is niet juist",
          "incorrect_cvc" => "De CVC code is niet geldig",
          "incorrect_zip" => "The card's zip code failed validation",
          "card_declined" => "Deze creditcard kan niet worden gebruikt (card declined)",
          "expired_card" => "Deze creditcard is verlopen (card expired)",
          "processing_error" => "Er is een fout opgetreden bij het verwerken van de creditcard",
          "rate_limit" => "An error occurred due to requests hitting the API too quickly.",
          "coupon" => "Deze kortingscode is niet geldig"}

        flash[:error] = errorMessages["#{@subscription.error}"]
        redirect_to new_subscription_url(plan_id: @plan.id)
        #using the render new action raises an error
     end	
	 end

   def show_multiple
    @subscription = Subscription.new
    @plan = Plan.find(params[:plan_id]) 
  end

  def create_multiple
    @plan = Plan.find(params[:plan_id])
    @subscription = CreateSubscription.call(
      @plan, 
      current_user.email, 
      ''
    )
  end

   def destroy
    @subscription = Subscription.find(params[:id])
    #find the subscription in the database
    @user = User.find_by(email: @subscription.email)
    #find the user in the database with the subscription
    customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
    #retrieve the user from stripe
    customer.subscriptions.retrieve(@subscription.stripe_id).delete
    @subscription.remove!
    destroy_job
    #delete these users subscription
    flash[:success] = "Uw vacature is verwijderd"
    redirect_to mijn_vacatures_user_path(@user)
    
    # check for current user or admin before filter
   end

	protected

	def load_plans
		@plans = Plan.where(published: true)
	end

	 def admin_user
     redirect_to(root_url) unless current_user.admin?
   end

  def destroy_job
    if @job = Job.where("guid =?", @subscription.guid).exists?
      @job = Job.where("guid =?", @subscription.guid)
      Job.destroy(@job)
    end
  end

  def correct_user
     @subscription = Subscription.find(params[:id])
     @user = User.find_by(id: @subscription.user_id)
     redirect_to(root_url) unless current_user?(@user)
  end

  def check_card
    plan = Plan.find(params[:plan_id])
    if current_user.stripe_customer_id?
      redirect_to show_multiple_path(plan_id: plan.id)    
    end
  end

  def check_customer_id
    unless current_user.stripe_customer_id?
      redirect_to root_path
    end
  end
end




