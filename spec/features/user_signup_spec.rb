require 'rails_helper'

describe "User sign up" do 
	
	scenario "With invalid information" do 
		visit signup_path
		expect(page).to have_content("Registreren")
		fill_in "Naam", with: "thomas"
		fill_in "Email", with: "invalid@asdf.nl"
		fill_in "Wachtwoord", with: "alidsd"
		#fails on password
		fill_in "Bevestig wachtwoord", with: "aasgtdfas"
		  click_button 'Registreren'
		  expect(page).to have_css('.alert-error')
	end

	scenario "With valid information" do 
		visit signup_path
		
		expect {
		  fill_in "Naam", with: "thomas"
		  fill_in "Email", with: "examplfdfe@asdfasdf.nl"
		  fill_in "Wachtwoord", with: "foobar"
		  fill_in "Bevestig wachtwoord", with: "foobar"
		    click_button 'Registreren'
		  }.to change(User, :count).by(1)

		  expect(page).to have_css('.alert-success')
		  within '.alert-success' do 
		  	expect(page).to have_content "is verzonden"
		  end
		  expect(current_path).to eq signin_path
		  expect(User.first.activated).to eq false
	end

	scenario 'as an non-activated user' do 
		user = create(:user, activated: false)
	    sign_in user
	    expect(page).to have_css('.alert-notice')
	    within '.alert-notice' do 
	    	expect(page).to have_content 'nog niet geactiveerd'
	    end
	end

	scenario 'acivating the account' do 
		@user = create(:user, activated: false, activation_token: '23424234')
		  expect(User.first.activated).to eq false
		visit edit_account_activation_path(@user.activation_token, email: @user.email)
		  expect(User.first.activated).to eq true
	end

	describe 're-sending the account activation mail' do 
		scenario 'with an existing, non active account' do 
			@user = create(:user, activated: false, activation_token: '234234234')
			  expect(User.first.activated).to eq false
			
			visit new_account_activation_path
			  expect(page).to have_content('Account activatie email opnieuw verzenden')
			fill_in 'Email', with: @user.email
			click_button 'Verzend instructies'
			  expect(page).to have_content 'is verzonden'
		end

		scenario 'with an existing, active account' do 
			@user = create(:user, activated: true)
			visit new_account_activation_path
			fill_in 'Email', with: @user.email
			click_button 'Verzend instructies'
			  expect(page).to have_content 'Geen inactief account gevonden voor dit Email adres'
		end

		scenario 'with a non-existing account' do 
			visit new_account_activation_path
			fill_in 'Email', with: 'nonexisting@example.com'
			click_button 'Verzend instructies'
			  expect(page).to have_content 'Geen inactief account gevonden voor dit Email adres'
		end
	end
end