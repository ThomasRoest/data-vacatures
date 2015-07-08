require 'rails_helper'

describe 'posting a free job listing' do 
  before :each do 
    @user = create(:user)
  end

  scenario "posting a job without signin in" do
    visit gratis_path
    expect(page).to have_content('gratis')
    click_button('Plaats nu een gratis vacature')
    expect(current_path).to eq signup_path
  end

  scenario "after signin in" do 
    sign_in(@user)
    visit gratis_path
    click_button('Plaats nu een gratis vacature')
    expect(current_path).not_to eq signup_path
  end
end