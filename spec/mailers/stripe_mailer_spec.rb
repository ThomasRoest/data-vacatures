require 'rails_helper'
require 'stripe_mock'

RSpec.describe StripeMailer, :type => :mailer do 

	let(:stripe_helper) { StripeMock.create_test_helper }
    	before { StripeMock.start }
    	after { StripeMock.stop }


	describe 'delete subcription email' do 
		before :each do 
			@user = FactoryGirl.create(:user)
			event = StripeMock.mock_webhook_event('customer.subscription.deleted')
			subscription = event.data.object
			# can also use custome events in fixtures webhooks file.json
			StripeMailer.customer_subscription_deleted(subscription).deliver
		end
    
		it 'delivers a delete subscription email' do 
		 expect(ActionMailer::Base.deliveries.count).to eq 1
		end

		it 'the email is sent the the right reciepient' do 
		 expect(ActionMailer::Base.deliveries.first.to).to match [@user.email]
		end

	end #end delete subscription email block

	describe 'admin invoice paid email' do 
		before :each do 
			event = StripeMock.mock_webhook_event('invoice.payment_succeeded')
			@subscription = FactoryGirl.create(:subscription, stripe_id:'su_00000000000000')
			invoice = event.data.object
			# can also use custome events in fixtures webhooks file.json
			StripeMailer.admin_invoice_paid(invoice).deliver
		end

		it 'delivers a invoice payment succeeded email' do 
			expect(ActionMailer::Base.deliveries.count).to eq 1
		end

		it 'the email is sent to the right reciepient' do 
			expect(ActionMailer::Base.deliveries.first.to).to match ['dv@datavacature.nl']
		end
	end

	describe 'admin dispute created email' do 
		before :each do 
			event = StripeMock.mock_webhook_event('charge.dispute.created')
			charge = event.data.object
			# can also use custome events in fixtures webhooks file.json
			StripeMailer.admin_dispute_created(charge).deliver
		end

		it 'delivers a dispute created email' do 
			expect(ActionMailer::Base.deliveries.count).to eq 2
		end

		it 'delivers the email to the right reciepient' do 
			expect(ActionMailer::Base.deliveries.first.to).to match ['dv@datavacature.nl']
		end

	end

end