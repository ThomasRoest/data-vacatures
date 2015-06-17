class AddLinkedinToJobapplications < ActiveRecord::Migration
  def change
  	add_column :jobapplications, :linkedin_url, :string
  end
end
