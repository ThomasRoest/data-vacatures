class AddSmallLogoToCourses < ActiveRecord::Migration
  def change
  	add_attachment :courses, :course_logo
  end
end
