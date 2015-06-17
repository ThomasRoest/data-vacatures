class UserMailer < ActionMailer::Base
  default from: 'contact@datavacature.nl'

  def account_activation(user)
    @user = user
    mail(to: user.email, subject: "Activeer account")
  end

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Wachtwoord herstel")
  end

  def contact_email(contact)
    @contact = contact
    mail(to: 'contact@datavacature.nl', from: @contact.email, :subject => "Contact form")
  end

  def test

    mail(to: 'test@test.nl', :subject => 'moh')
  end
 
end
