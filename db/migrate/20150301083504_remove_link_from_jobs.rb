class RemoveLinkFromJobs < ActiveRecord::Migration
  def change
  	remove_column :jobs, :link
  end
end
