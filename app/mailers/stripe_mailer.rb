class StripeMailer < ActionMailer::Base
	default from: 'contact@datavacature.nl'

	def admin_dispute_created(charge)
		@charge = charge
		mail(to: 'dv@datavacature.nl', subject: "Dispute created on charge #{@charge.charge}").deliver
	 end

	def admin_invoice_paid(invoice)
		@invoice = invoice
	    @subscription = Subscription.find_by!(stripe_id: @invoice.subscription)
        mail(to: 'dv@datavacature.nl', subject: 'invoice paid!')
	end

	 def customer_subscription_deleted(subscription)
	 	@subscription = subscription
	 	@user = User.find_by(stripe_customer_id: @subscription.customer )
	 	mail(to: @user.email, subject: (t :job_delete_mailer_title))
	 end
end