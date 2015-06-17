class AddMarkdownContentToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :markdown, :text
  end
end
