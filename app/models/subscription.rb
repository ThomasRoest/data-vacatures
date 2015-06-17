class Subscription < ActiveRecord::Base
  include AASM

  aasm column: 'state' do 
  	state :pending, initial: true
  	state :processing
  	state :finished
  	state :errored
    state :deleted

 	event :process do 
 		transitions from: :pending, to: :processing
 	end

 	event :finish do 
 		transitions from: :processing, to: :finished
 	end

 	event :fail do 
 		transitions from: :processing, to: :errored
 	 end

  event :remove do 
    transitions to: :deleted
   end
  end

  before_create :populate_guid
  belongs_to :user
  belongs_to :plan
  validates_uniqueness_of :guid
  # validates :email, presence: true

  has_paper_trail

  scope :state_finished, -> { where("state =?", "finished")}
  default_scope { order('created_at DESC')}

  private
   def populate_guid
  	  self.guid = SecureRandom.uuid()
  end
end
