FactoryGirl.define do
	factory :topic do
		sequence(:name) { |n| "Person #{n}" }
		id 1
	end

end