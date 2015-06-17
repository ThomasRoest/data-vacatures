require 'rails_helper'

describe "Resetting a Password" do 
	scenario "with invalid email" do 
		visit new_password_reset_path
		expect(page).to have_content('Wachtwoord herstellen')
		fill_in 'Email', with: "invalid@invalid.com"
		click_button 'Verzend instructies voor nieuw wachtwoord'
		expect(page).to have_css('.alert-error')
		  within '.alert-error' do 
			expect(page).to have_content('Account met dit email adres niet gevonden.')
		  end
	end

	scenario "with valid email" do 
		user = create(:user)
		visit new_password_reset_path
		fill_in 'Email', with: user.email
		click_button 'Verzend instructies voor nieuw wachtwoord'
		expect(page).to have_css('.alert-success')
		within '.alert-success' do 
			expect(page).to have_content('Instructies voor wachtwoord herstel verzonden.')
		end
		  # expect(ActionMailer::Base.deliveries.count).to eq 1
	end
end

