class Jobapplication < ActiveRecord::Base
	belongs_to :user
	belongs_to :job
	before_save { self.email = email.downcase }
	has_attached_file :cv
  has_attached_file :letter
	
	validates  :name, :content, presence: true
 	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true,
	 		   format: { with: VALID_EMAIL_REGEX }
	default_scope { order('created_at DESC')}

 	validates_attachment :cv, :content_type => { :content_type => ['application/pdf','application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/msword'] },
						 :file_name => { :matches => [/pdf\Z/, /docx?\Z/] },
						 :size => { :in => 0..5.megabytes }
	
	validates_attachment :letter, :content_type => { :content_type => ['application/pdf','application/vnd.openxmlformats-officedocument.wordprocessingml.document','application/msword'] },
	 					 :file_name => { :matches => [/pdf\Z/, /docx?\Z/] },
	 					 :size => { :in => 0..5.megabytes }

	def self.search(query)
		where("name like ?", "%#{query}%")
	end

	# more queries where("firstname ilike :q or lastname ilike :q ", q: "%#{query}%") 					
end
