class Topic < ActiveRecord::Base
	#add paper trail for backup?
	has_many  :posts, dependent: :destroy
	has_many  :toprelations, foreign_key: "topic_follower_id", dependent: :destroy
	has_many  :reverse_toprelations, foreign_key: "topic_followed_id",
								    class_name: "Toprelation",
								    dependent: :destroy
	has_many  :topic_followers, through: :reverse_toprelations, source: :topic_follower
	has_attached_file :avatar, :styles => { :large => "155x155#", :medium => "85x85#", :thumb => "45x45#" }
	validates_attachment :avatar, :content_type => { :content_type => ["image/jpeg", "image/png"] },
						 :file_name => { :matches => [/png\Z/, /jpe?g\Z/] },
						 :size => { :in => 0..3.5.megabytes }
	validates :name, presence: true, uniqueness: true
	validates :id, uniqueness: :true

	default_scope { order('created_at DESC')}

	 def slug
    	name.downcase.parameterize
   end

    def to_param
    	"#{id}-#{slug}"
    end
end
