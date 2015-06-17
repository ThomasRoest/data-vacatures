class Plan < ActiveRecord::Base
	has_paper_trail
	validates :stripe_id, uniqueness: true
end

# CreatePlan.call(stripe_id: 'vacature-basis', name: 'vacature-basis', amount: 2000, interval: 'month', description: 'vacature basis', published: true)

