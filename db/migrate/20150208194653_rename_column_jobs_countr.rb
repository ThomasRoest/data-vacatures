class RenameColumnJobsCountr < ActiveRecord::Migration
  def change
  	rename_column :jobs, :country, :place
  end
end
