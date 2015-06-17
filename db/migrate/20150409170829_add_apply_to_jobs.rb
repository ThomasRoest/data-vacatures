class AddApplyToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :directapply, :boolean, default: false
  end
end
