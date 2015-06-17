FactoryGirl.define do
  factory :job do
  	id 1
  	place 'Amsterdam'
  	title 'Job title'
  	description 'Job description'
  	email 'user@example.com'
  	user_id 12
  	company 'Test company'
    job_type 'Freelance'
  	guid '234sdf-2342sdf-324ksdf'
    directapply false
    summary 'this is the example summary'
  end
end
