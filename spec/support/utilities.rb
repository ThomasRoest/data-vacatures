include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    # Sign in when not using Capybara.
    remember_token = User.new_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    #this is broken, all test using no_capybara are commented out.
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Wachtwoord", with: user.password
    click_button "Aanmelden"
  end
end