class AddFkToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :user_id, :int
    add_column :subscriptions, :feed_id, :int
  end
end
