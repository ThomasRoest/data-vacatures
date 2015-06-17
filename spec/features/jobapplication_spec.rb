require 'rails_helper'

describe "applying for a job" do 
	before :each do 
		@user = create(:user)
		@subscription = create(:subscription, state: 'finished')
		@user.subscriptions << @subscription
		
	end

	scenario 'there should be a directapply button if directapply == true' do 
		@job = create(:job, user_id: @user.id, guid: @subscription.guid, directapply: true)
		@user.jobs << @job
		visit job_path(@job)
		  expect(page).to have_link('Solliciteer direct', href: new_jobapplication_path(job_id: @job.id))
	end

	scenario 'there should not be a directapply button if directapply == false' do 
		@job = create(:job, user_id: @user.id, guid: @subscription.guid, directapply: false)
		@user.jobs << @job
		visit job_path(@job)
		  expect(page).not_to have_link('Solliciteer direct', href: new_jobapplication_path(job_id: @job.id))
	end

	scenario 'applying without signing in is not possible' do
		@job = create(:job, user_id: @user.id, guid: @subscription.guid, directapply: true)
		@user.jobs << @job
		visit job_path(@job)
		  expect(page).to have_link('Solliciteer direct', href: new_jobapplication_path(job_id: @job.id))
		click_link 'Solliciteer direct'
		  expect(page).to have_content('Meld je aan om verder te gaan')
	end

	scenario 'applying after signing in' do 
		@job = create(:job, user_id: @user.id, guid: @subscription.guid, directapply: true)
		@user.jobs << @job
		@user2 = create(:user)
		sign_in @user2
		visit job_path(@job)
		click_link 'Solliciteer direct'
		  expect(page).to have_content('Solliciteer')
		  expect {
		  	fill_in 'Naam', with: 'username'
		  	fill_in 'Email', with: 'user@example.com'
		  	fill_in 'Motivatie', with: 'mijn motivatie'
		  	click_button 'Verstuur sollicitatie'
		  }.to change(Jobapplication, :count).by(1)
		  expect(@user2.jobapplications.count).to eq(1)
		  expect(ActionMailer::Base.deliveries.count).to eq(1)  
	end
end


describe 'checking the job application' do 
	before :each do 
		@user = create(:user)
		@subscription = create(:subscription, state: 'finished')
		@user.subscriptions << @subscription
		@job = create(:job, user_id: @user.id, guid: @subscription.guid, directapply: true)
		@user.jobs << @job
		@user2 = create(:user)
		@jobapplication = create(:jobapplication, user_id: @user2.id, job_id: @job.id)
	end

	scenario "the user should not be able to visit it's own job application"  do 
		sign_in @user2
		visit jobapplication_path(@jobapplication)
		  expect(current_path).to eq root_path
	end

	scenario 'the job owner should be able to visit the job application' do 
		sign_in @user
		visit jobapplication_path(@jobapplication)
		  expect(current_path).to eq jobapplication_path(@jobapplication)
		  expect(page).to have_content 'Motivatie'
	end
end