class AddJobidToJobapplications < ActiveRecord::Migration
  def change
  	add_column :jobapplications, :job_id, :integer
  end
end
