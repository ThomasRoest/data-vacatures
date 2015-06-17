 require 'rails_helper'
 require 'stripe_mock'

describe 'Purchasing a subscription' do 
	let(:stripe_helper) { StripeMock.create_test_helper }
	before { StripeMock.start }
	after { StripeMock.stop }
	

	scenario 'Without being logged in' do 
		visit new_subscription_path
		  expect(page).to have_css('.alert-notice')
			within '.alert-notice' do 
				expect(page).to have_content('Meld je aan om verder te gaan')
			end
	end

	scenario 'after logging in' do 
		user = create(:user)
		plan = create(:plan)
		sign_in user
		visit jobs_path
		click_link "Plaats een vacature"
		  expect(page).to have_content('Plaats een vacature')
		click_link 'Selecteer'
		  expect(page).to have_content(user.email)
	end

	scenario 'with valid cc information' do 
		user = create(:user)
		plan = create(:plan)
		sign_in user
		visit new_subscription_path(plan_id: plan.id)
		  expect(page).to have_content(user.email)

		customer = Stripe::Customer.create({
			email: user.email,
			card: stripe_helper.generate_card_token
			})

		subscription = create(:subscription, email: customer.email, state: 'finished' )
		  expect(subscription.email).to eq user.email

		visit newjob_path(guid: subscription.guid)
		expect(page).to have_content('Bedrijfsnaam')
	end

	scenario 'showing the form if customer id not present' do 
		user = create(:user, stripe_customer_id: '')
		plan = create(:plan)
		sign_in user
		visit jobs_path
		click_link "Plaats een vacature"
		click_link 'Selecteer'

		  expect(page).to have_content('Credit Card Nummer')
		  expect(page).to have_content('CVC code')
		  # expect(page).to have_content('huidige')
		  # expect(page).to have input field creditcard 
	end

	scenario 'showing the multiple subscriptions for if stripe_customer_id present' do 
		user = create(:user)
		plan = create(:plan)
		sign_in user
		visit jobs_path
		click_link "Plaats een vacature"
		click_link 'Selecteer'

		  expect(page).not_to have_content('Credit Card Nummer')
		  expect(page).not_to have_content('CVC code')
		  # expect(page).to have_content('huidige')
		  # expect(page).to have input field creditcard 
	end
end

