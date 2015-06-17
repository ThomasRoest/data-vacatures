class Toprelation < ActiveRecord::Base
	belongs_to :topic_follower, class_name: "User"
	belongs_to :topic_followed, class_name: "Topic"
	validates :topic_follower_id, presence: true
	validates :topic_followed_id, presence: true
end
