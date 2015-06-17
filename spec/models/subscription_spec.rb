require 'rails_helper'
require 'stripe_mock'

RSpec.describe Subscription, :type => :model do
	let(:stripe_helper) { StripeMock.create_test_helper }
	before { StripeMock.start }
  after { StripeMock.stop }

  it 'creating a stripe customer' do 
  	user = create(:user)
  	customer = Stripe::Customer.create({
  		email: user.email,
  		card: stripe_helper.generate_card_token
  		})
  	expect(customer.email).to eq(customer.email)

  end

  it "mocks a declined card error" do
  # Prepares an error for the next create charge request
  StripeMock.prepare_card_error(:card_declined)

  expect { Stripe::Charge.create }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('card_declined')
  }
end
end
