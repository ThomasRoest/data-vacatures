require 'rails_helper'

describe "User Login" do 
	
	scenario "With valid information" do 
		user = create(:user)
		#persist a user to the database
		visit signin_path
		expect(page).to have_content("Aanmelden")
		fill_in "Email", with: user.email
		fill_in "Wachtwoord", with: user.password
		click_button "Aanmelden" 
		expect(page).not_to have_content('Aanmelden')
	end

	scenario "With invalid information" do 
		user = create(:user)
		visit signin_path
		expect(page).to have_content("Aanmelden")
		fill_in "Email", with: "invalid@bullshit.nl"
		fill_in "Wachtwoord", with: "whatever"
		click_button "Aanmelden" 
		expect(page).to have_content('Onjuiste email/wachtwoord combinatie')
	end

	scenario "Test signin method" do 
		user = create(:user)
		sign_in user
		expect(page).not_to have_content("Aanmelden")
	end

	scenario "without activating the account" do 
		user = create(:user, activated: false)
		sign_in user
		expect(page).to have_css('.alert-notice')
		within '.alert-notice' do 
			expect(page).to have_content('niet geactiveerd')
		end
	end
end