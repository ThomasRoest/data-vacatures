class CreateFreeSubscriptions < ActiveRecord::Migration
  def change
    create_table :free_subscriptions do |t|
      t.string :company
      t.string :guid
      t.timestamps
    end
  end
end
