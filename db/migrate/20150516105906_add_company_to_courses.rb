class AddCompanyToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :company, :string
  end
end
