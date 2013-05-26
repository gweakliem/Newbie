class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :link
      t.string :description
      t.integer :feed_id
      t.date :pubDate

      t.timestamps
    end
  end
end
