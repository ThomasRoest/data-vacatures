# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :plan do
    stripe_id nil
    name "test_plan"
    description "test_plan"
    amount 2500
    interval "Month"
    published true
    permalink 'vacature-basis'
  end
end

