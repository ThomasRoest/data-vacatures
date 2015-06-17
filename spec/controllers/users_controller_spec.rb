require 'rails_helper'
# require 'stripe_mock'

RSpec.describe UsersController, :type => :controller do
  
	describe 'new user' do 
		it 'renders users#new' do 
			get :new
		  expect(response).to render_template :new
		end

		# it 'creates a new user' do 
		# 	expect {
		# 	  post :create, user: attributes_for(:user)
		# 	  }.to change(User, :count).by(1)
		# end

		it 'renders user#show' do 
			@user = FactoryGirl.create(:user)
			expect(User.count).to eq 1
			expect(@user.id).to eq 1
			# sign_in user
			# get :edit, id: @user
		end
	end
end