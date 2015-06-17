class RemoveAttachmentfromCourses2 < ActiveRecord::Migration
  def change
  	remove_attachment :courses, :course_image
  end
end
