describe UserMailer do 
	describe 'contact email' do 

		before(:each) do
			@contact = Contact.new(name: "thomas", email: "user@example.com", content: "test")
			UserMailer.contact_email(@contact).deliver
		end

		it 'sends an email' do
			expect(ActionMailer::Base.deliveries.count).to eq 1
		end

		it 'sends an email to the correct recipient' do
      		expect(ActionMailer::Base.deliveries.first.to).to match ['contact@datavacature.nl']
    	end

    	it 'sends an email from the correct sender' do
      		expect(ActionMailer::Base.deliveries.first.from).to match [@contact.email]
    	end

    	it 'sends an email with the correct subject' do
      		expect(ActionMailer::Base.deliveries.first.subject).to match 'Contact form'
    	end
	end

	describe 'Account activation mail' do 
		before :each do 
			@user = FactoryGirl.create(:user)
			UserMailer.account_activation(@user).deliver
		end

		it 'should deliver an email' do 
			expect(ActionMailer::Base.deliveries.count).to eq 1
		end

		it 'should be sent to the right recepient' do 
			expect(ActionMailer::Base.deliveries.first.to).to match [@user.email]
		end
	end
end