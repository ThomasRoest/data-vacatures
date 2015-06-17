# describe JobMailer do 
	
# 	# # describe 'job application mail, with attachment' do

# 	# # 	before(:each) do 
			
# 	# # 		# @letter = File.new("#{Rails.root}/spec/factories/testdoc.doc")
# 	# # 		# @cv = File.new("#{Rails.root}/spec/factories/testpdf.pdf")
			
# 	# # 		  @jobapplication = Roomsdivisionjobapplication.new
# 	# # 		 #(email: 'user@example.com',
# 	# # 		# 	companyemail: 'test@example.com',
# 	# # 		# 	jobtitle: 'test',
# 	# # 		# 	jobcountry:"test",
# 	# # 		# 	name: 'test',
# 	# # 		# 	content: 'test'
# 	# # 		# 	#letter: @letter,
# 	# # 		# 	#cv: @cv
# 	# # 		# 	)
				
# 	# # 			JobMailer.jobapplication_email(@jobapplication).deliver
# 	# # 	end

# 	# 	it 'sends an email' do
# 	# 		expect(ActionMailer::Base.deliveries.count).to eq 1
# 	# 	end


# 	# end

	



# 	describe 'job confirmation mail' do
		
# 		before(:each) do 
# 			@jobapplication = Jobapplication.new(email: 'user@example.com')
# 			JobMailer.jobapplication_confirm_email(@jobapplication).deliver
# 		end

# 		it 'sends an email' do 
# 			expect(ActionMailer::Base.deliveries.count).to eq 1
# 		end

# 		it 'sends an email to the correct recipient' do 
# 			expect(ActionMailer::Base.deliveries.first.to).to match ['user@example.com']
# 		end

# 		it 'sends an email from the correct sender' do
# 			expect(ActionMailer::Base.deliveries.first.from).to match ['jobs@hospitalityhangout.com']
# 		end

# 		it 'sends an email with the correct subject' do 
# 			expect(ActionMailer::Base.deliveries.first.subject).to match 'Thank you for your application'
# 		end
# 	end
# end

# #test the job application JobMailer
# #test job application confirmation mail