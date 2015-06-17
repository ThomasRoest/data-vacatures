require 'rails_helper'
require 'stripe_mock'

RSpec.describe ReceiptMailer, :type => :mailer do 
	let(:stripe_helper) { StripeMock.create_test_helper }
	before { StripeMock.start }
	after { StripeMock.stop }

	describe 'invoice payment succeeded receipt mailer' do 
		before :each do 
			
			@subscription = FactoryGirl.create(:subscription, email: 'user@example.com', stripe_id:'su_00000000000000')
			@user = FactoryGirl.create(:user, email: 'user@example.com')
			event = StripeMock.mock_webhook_event('invoice.payment_succeeded')
			invoice = event.data.object
			pdf = File.new("#{Rails.root}/spec/factories/testpdf.pdf")
			ReceiptMailer.receipt(invoice).deliver
		end

		it 'should deliver an email' do 
			expect(ActionMailer::Base.deliveries.count).to eq 1
		end

		it 'the invoice should be sent to the email associated with the subscription' do 
			expect(ActionMailer::Base.deliveries.first.to).to match [@subscription.email && @user.email]
		end

		it 'sends an email from the correct sender' do
      expect(ActionMailer::Base.deliveries.first.from).to match ['contact@datavacature.nl']
    end

    it 'sends an email with the correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to match 'factuur'
    end

    it 'has an invoice as attachment' do 
    	expect(ActionMailer::Base.deliveries.first.attachments.count).to eq 1
    end
	end
end