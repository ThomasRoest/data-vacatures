require 'rails_helper'

describe "creating a post" do 

	before :each do 
		@user = create(:user)
		sign_in @user
	end

	scenario 'as a signed in user' do 
		visit new_post_path
		expect(current_path).to eq new_post_path

       expect(page).to have_selector('#parsed_markdown')
       expect(page).to have_selector('#post_markdown')
       expect(page).to have_selector('#submit-post-form')
       expect(page).to have_selector('#new_post')
	end
end