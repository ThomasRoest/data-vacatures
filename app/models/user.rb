class User < ActiveRecord::Base
	attr_accessor :remember_token, :activation_token, :reset_token
	before_save :downcase_email
	before_create :create_activation_digest
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	# has_many :sales, dependent: :destroy
	has_many :subscriptions, dependent: :destroy
	has_many :jobs, dependent: :destroy
	has_many :jobapplications, dependent: :destroy
	
	# user relationships
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy	
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  	# topic relationships = toprelations because of the activerecord foreign keys naming character limit)
  has_many :toprelations, foreign_key: "topic_follower_id", dependent: :destroy
  has_many :followed_topics, through: :toprelations, source: :topic_followed
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: 	true, 
					  format: 		{ with: VALID_EMAIL_REGEX },
					  uniqueness: 	{ case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6, allow_nil: true}

  has_attached_file :avatar, :styles => { :large => "155x155#", :medium => "85x85#", :thumb => "45x45#" }
	# '#' will resize and to exact size, the '> will keep the proportions'
	validates_attachment :avatar, 
					     :content_type => { :content_type => ["image/jpeg", "image/png"], :message => "is not valid, please upload the file in jpeg on png format"},
						 :file_name => { :matches => [/png\Z/, /jpe?g\Z/] },
						 :size => { :in => 0..1.5.megabytes, :message => "is not valid (max 3.5 MB)" }

	#returns the hash digest of a string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
	end

	#returns a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	#remembers a user in the database for use in persistent sessions
	def remember
		self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
	end

	#returns true of the given token matches the digest
	def authenticated?(attribute, token)
	   digest = send("#{attribute}_digest")
	   return false if digest.nil?
       BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
    	update_attribute(:remember_digest, nil)
    end
    
    #activates the account
    def activate
    	update_columns(activated: true, activated_at: Time.zone.now)
    end
   
    def send_activation_email
    	UserMailer.account_activation(self).deliver
    end

    def re_send_activation_email
    	self.activation_token = User.new_token
    	new_digest = User.digest(activation_token)
	  	self.update_attribute(:activation_digest, new_digest)
    	UserMailer.account_activation(self).deliver
    end

    #sets the password reset attributes
    def create_reset_digest
    	self.reset_token = User.new_token
    	update_columns(reset_digest:  User.digest(reset_token),
                       reset_sent_at: Time.zone.now)
    end

    def send_password_reset_email
    	UserMailer.password_reset(self).deliver
    end

    def password_reset_expired?
    	reset_sent_at < 2.hours.ago
    end

	def feed
		Post.from_usersandtopics_followed_by(self)
	end

	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy!
	end


	def topic_following?(other_topic) 
		self.toprelations.find_by(topic_followed_id: other_topic.id)
	end

	def topic_follow!(other_topic)
		self.toprelations.create!(topic_followed_id: other_topic.id)
	end

	def topic_unfollow!(other_topic)
		self.toprelations.find_by(topic_followed_id: other_topic.id).destroy
	end

	private

	  def downcase_email
	  	self.email = email.downcase
	  end

	  def create_activation_digest
	  	self.activation_token = User.new_token
	  	self.activation_digest = User.digest(activation_token)
	  end
end


 