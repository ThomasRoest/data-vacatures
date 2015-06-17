class CreateSubscription
 def self.call(plan, email_address, token, discount = {})
   user = CreateUser.call(email_address)
   #this checks for the user
  
   subscription = Subscription.new(
    plan: plan, 
    user: user, 
    email: user.email,
    amount: plan.amount
    )
    
   subscription.process!
   #triggers AASM states
  
  begin
  
   stripe_sub = nil
   if user.stripe_customer_id.blank?
    customer = Stripe::Customer.create(
     card: token,
     email: user.email,
     plan: plan.stripe_id,
     coupon: discount
    )
  
    user.stripe_customer_id = customer.id
    user.save!
    stripe_sub = customer.subscriptions.first

   else

    customer = Stripe::Customer.retrieve(user.stripe_customer_id)
    if customer.sources.data.blank?
       customer.sources.create(card: token)
    end
    #if customer id is present and card was removed
    stripe_sub = customer.subscriptions.create(
     plan: plan.stripe_id
    )

   end 
    subscription.stripe_id = stripe_sub.id
    subscription.finish!
    subscription.save!
    
    #AASM state finish
   
   rescue Stripe::CardError => e
    subscription.fail!
    subscription.update_attributes(error: e.code)
   rescue Stripe::InvalidRequestError => e
    subscription.fail!
    subscription.update_attributes(error: e.param)
    # error for invalid coupons
   
  end
  
 subscription

 end
end








        


    
    