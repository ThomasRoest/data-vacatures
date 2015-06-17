class RemoveColumnsFromJobapplications < ActiveRecord::Migration
  def change
  	remove_column :jobapplications, :companyemail
  	remove_column :jobapplications, :jobtitle
  	remove_column :jobapplications, :jobcompany
  	remove_column :jobapplications, :jobcountry
  end
end
