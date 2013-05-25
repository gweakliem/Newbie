class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :xmlUrl
      t.string :htmlUrl
      t.string :title
      t.string :description
      t.date :lastRetrieve
      t.string :etag

      t.timestamps
    end
  end
end
