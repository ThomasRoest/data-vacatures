require 'rails_helper'
# require 'stripe_mock'

RSpec.describe ContactsController, :type => :controller do
  
	describe 'new contacts' do 
		it 'renders contacts#new' do 
			get :new
		  expect(response).to render_template :new
		end
	end
end