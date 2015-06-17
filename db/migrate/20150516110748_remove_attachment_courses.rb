class RemoveAttachmentCourses < ActiveRecord::Migration
  def change
  	remove_attachment :courses, :course_logo
  end
end
