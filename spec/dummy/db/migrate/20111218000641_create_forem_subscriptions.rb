class CreateForemSubscriptions < ActiveRecord::Migration
  def change
    create_table :forem_subscriptions do |t|
      t.integer :subscriber_id
      t.integer :topic_id
    end
  end
end
