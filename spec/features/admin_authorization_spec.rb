require 'rails_helper'

describe 'Accessing the user index page' do 
	
	scenario 'For non-admin users' do 
	  user = create(:user)
	  sign_in user
	  visit users_path
	    expect(page).not_to have_content('Alle gebruikers')
	    expect(current_path).to eq root_path
	end

	scenario 'for admin users' do 
		user1 = create(:user, stripe_customer_id: '')
		admin = create(:admin)
		sign_in admin
		visit users_path
		  expect(page).to have_content('Alle gebruikers')
		  expect(page).to have_link('delete', href: user_path(user1))

		  expect {
			  click_link 'delete', href: user_path(user1)
		  }.to change(User, :count).by(-1)
		  expect(page).not_to have_link('delete', href: user_path(user1))
	end
end
