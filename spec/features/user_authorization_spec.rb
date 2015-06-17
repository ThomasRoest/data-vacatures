require 'rails_helper'

describe "User edit" do 
	scenario "As the wrong user" do 
		user1 = create(:user, id: 1)
		user2 = create(:user, id: 2)
		sign_in user2
		visit user_path(user2)
		expect(page).to have_content('Profiel')
		visit edit_user_path(user2)
		expect(page).to have_content('Wijzig instellingen')
		visit edit_user_path(user1)
		expect(page).not_to have_content('Wijzig instellingen')
		expect(current_path).to eq(root_path)
	end
end

describe "User destroy" do 
	scenario "As a non-admin user" do 
		user = create(:user)
		sign_in user
		visit users_path
		expect(current_path).to eq root_path
	end
end

