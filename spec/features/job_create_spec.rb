require 'rails_helper'

describe "the user jobs dashboard" do 

	before :each do 
		@user = create(:user)
		sign_in @user
	end

	scenario 'without a subscription' do 
		visit user_path(id: @user)
		  expect(page).to have_content(@user.name)
		  expect(page).not_to have_content('Mijn vacatures')
	end

	scenario 'link to dashboard if the user has subscriptions with state finished' do
		@subscription = create(:subscription, state: 'finished')
		@user.subscriptions << @subscription
			expect(@user.subscriptions.count).to eq 1

		visit user_path(id: @user)
		  expect(page).to have_content('Mijn vacatures')
	end

	scenario 'Accessing the job dashboard from the profile page ' do
  	@subscription = create(:subscription, state: 'finished')
		@user.subscriptions << @subscription
		visit user_path(id: @user)
		click_link 'Mijn vacatures'
		  expect(page).to have_content('Verwijder vacature')
	end
	# scenario 
	scenario 'Only show subscriptions with state finished' do
		@subscription = create(:subscription, state: 'errored')
		@user.subscriptions << @subscription
		@subscriptions = @user.subscriptions.state_finished
	
		visit user_path(id: @user)
		  expect(page).not_to have_content('Mijn vacatures')
		visit mijn_vacatures_user_path(@user)
		  expect(page).not_to have_content('Verwijder vacature')
		  expect(@subscriptions.count).to eq 0
	end

	scenario 'The links should change when a job is posted ' do
  	@subscription = create(:subscription, state: 'finished')
		@user.subscriptions << @subscription

		visit mijn_vacatures_user_path(id: @user.id)
		  expect(page).to have_link('Plaats vacature', href: newjob_path(guid: @subscription.guid))
		  expect(@user.subscriptions.state_finished.count).to eq 1

		 @job = create(:job, user_id: @user.id, guid: @subscription.guid)
		 @user.jobs << @job
		    expect(@user.jobs.count).to eq 1
		    expect(@user.jobs.first.guid).to match (@user.subscriptions.first.guid)

		 visit mijn_vacatures_user_path(id: @user.id)
		    expect(page).to have_link("#{@job.title}" + ' | ' + "#{@job.place}", href: job_path(@job) )
	end
end #end dashboard test

describe 'Posting a new job listing' do 
	
	before :each do 
		@user = create(:user)
		sign_in @user
		@subscription = create(:subscription, state: 'finished')
		@user.subscriptions << @subscription
		
	end

	scenario 'From the dashboard' do 

      visit mijn_vacatures_user_path(id: @user.id)
      click_link 'Plaats vacature'
       expect(page).to have_content('Bedrijfsnaam')
       expect(page).to have_selector('#parsed_markdown')
       expect(page).to have_selector('#job_markdown')
       expect(page).to have_selector('#submit-job-form')
       expect(page).to have_selector('#new_job')
       

       expect {
       	  fill_in 'Samenvatting', with: 'example summary'
       	  fill_in 'Bedrijfsnaam', with: 'test company'
       	  fill_in 'Plaats', with: 'Amsterdam'
       	  fill_in 'Betreft Functie', with: 'functietitel'
       	   select('Freelance', :from => 'Dienstverband')
       	  find('#parsed_markdown').set('Test functieomschriving')
       	  # fill_in 'Contact email', with: 'user@example.com'

       	  click_button 'Plaats vacature'

       	}.to change(Job, :count).by(1)

       	expect(Job.first.guid).to eq (@subscription.guid)
       	expect(@user.jobs.count).to eq(1)
	end
end

describe 'with an errored subscription' do 
	scenario 'the job link with guid should not be valid' do 
	@user = create(:user)
    sign_in @user
	@subscription = create(:subscription, state: 'errored')
	@user.subscriptions << @subscription
	  visit newjob_path(guid: @subscription.guid)
	  expect(current_path).to eq root_path
	  within '.alert-error' do
	  	expect(page).to have_content('Deze link is niet geldig')
	  end
	end
end

describe 'editing a job listing' do 

	before :each do 
		@user = create(:user)
		@subscription = create(:subscription, state: 'finished')
		@user.subscriptions << @subscription
		@job = create(:job, user_id: @user.id, guid: @subscription.guid)
		@user.jobs << @job
	end

	scenario 'as the right user' do 
		  expect(@user.jobs.count).to eq 1
		  expect(@user.subscriptions.count).to eq 1
		  sign_in @user
		  visit job_path(id: @job.id)
		    expect(page).to have_content(@job.title)
		    expect(page).to have_link('Wijzig vacature', href: edit_job_path(@job))

		  click_link 'Wijzig vacature'
		    expect(current_path).to eq edit_job_path(@job)
		    expect(page).to have_content 'Bedrijfsnaam'
		    expect(page).to have_selector('#parsed_markdown')
		    expect(page).to have_selector('#job_markdown')
		    expect(page).to have_selector('#submit-job-form')
		    expect(page).to have_selector('.edit_job')
	end

	scenario 'as the wrong user' do 
		user2 = create(:user)
		sign_in user2
		visit job_path(@job)
		  expect(page).to have_content(@job.title)
		  expect(page).not_to have_content('Wijzig vacature')
		visit edit_job_path(@job)
		  expect(current_path).not_to eq edit_job_path(@job)
		  expect(current_path).to eq root_path
	end

	scenario 'deleting the subscription, changing state to deleted' do
		sign_in @user
		visit mijn_vacatures_user_path(id: @user.id)
		expect(page).to have_content('Verwijder')
		  # cannot delete with capybara (connecting with stripe)
		@subscription.remove!
		  expect(@subscription.state).to eq 'deleted'
	end
end


