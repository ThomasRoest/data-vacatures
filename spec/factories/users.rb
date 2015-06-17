FactoryGirl.define do
	factory :user do
		sequence(:name) { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"
		activated true
		stripe_customer_id "cus_00000000000000"

		factory :admin do
			admin true
		  end
	    end

		factory :subscription do
			id nil
    		user nil
    		plan nil
    		stripe_id "MyString"
    		guid '234234sdfjaksj3434'
    		email nil
    		state nil
		end

		factory :user_subscription do
			user
			subscription
		end

end