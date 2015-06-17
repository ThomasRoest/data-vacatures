class AddFreeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :free, :boolean, default: false
  end
end
