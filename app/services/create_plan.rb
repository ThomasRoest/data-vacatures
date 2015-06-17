class CreatePlan
	#for adding plans to the database and stripe!
	def self.call(options={})
		plan = Plan.new(options)
		if !plan.valid?
			return plan
		end

		begin
			Stripe::Plan.create(
              id: options[:stripe_id],
              amount: options[:amount],
              currency: 'eur',
              interval: options[:interval],
              name: options[:name],
             )
			#don't add custom attributes here, doesn't work via Stripe
		rescue Stripe::StripeError => e 
			plan.errors[:base] << e.message
			return plan
		end
        plan[:permalink] = "vacature-basis"
        #setting the custom permalink attribute
        plan.save

		return plan
	end
end