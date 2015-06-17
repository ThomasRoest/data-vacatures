class AddCategoryToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :category, :string
  end
end
