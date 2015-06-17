# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stripe_webhook do
    stripe_id "MyString"
  end
end
