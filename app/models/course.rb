class Course < ActiveRecord::Base
	validates :title, presence: true
	validates :description, presence: true, length: { maximum: 220 }
	# has_attached_file :course_image, :styles => { :medium => "100%", :small => "150x150>"}
	# validates_attachment_content_type :course_image, :content_type => /\Aimage\/.*\Z/

  default_scope { order('created_at DESC')}
end
