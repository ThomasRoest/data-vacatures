require 'rails_helper'
# require 'stripe_mock'

RSpec.describe StaticPagesController, :type => :controller do
  
	describe 'static pages' do 
		it 'renders static_pages#help' do 
			get :help
		    expect(response).to render_template :help
		end

		it 'renders static_pages#about' do 
			get :about
		    expect(response).to render_template :about
		end

	end
end