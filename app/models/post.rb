class Post < ActiveRecord::Base
  before_save :embedly_embed
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  # validates :embed_url,  => { :message => "oops this seems to be an invalid video url!"}
  validates :title, presence: true
  validates :user_id, presence: true
  validates :topic_id, presence: true 
  validates :topic, :presence => { :message => 'does not exist, please choose another topic.' }
  default_scope -> { order('created_at DESC') }
  # scope :lp_link, -> { where("title =?", "Big data introductie")}

  # Returns osts from the users and topics being followed by the given user.
  def self.from_usersandtopics_followed_by(user)

    followed_topic_ids = "SELECT topic_followed_id FROM toprelations
                         WHERE topic_follower_id = :user_id"
    followed_user_ids =  "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id"


    where("topic_id IN (#{followed_topic_ids}) OR user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
    # the OR topic_id is where the own posts are selected, so this does not make
  end 

  def slug
    title.downcase.parameterize
  end

  def to_param
    "#{id}-#{slug}-"
  end

  def self.search(query)
    where("title like ?", "%#{query}%")
  end

  private

  def embedly_embed
      if self.video_url? 
        embedly_api = Embedly::API.new :key => ENV['EMBEDLY_API_KEY'], :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
        url = self.video_url
        embedly_response = embedly_api.oembed(url: url)
        embedly_object = embedly_response[0]
          if embedly_object.type == "error"    
            self.embed_url = "the url #{self.video_url} seems to be invalid."
          else
            self.embed_url = embedly_object.html
          end
      end
  end
end