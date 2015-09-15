class CreateRssFeeds < ActiveRecord::Migration
  def change
    create_table :rss_feeds do |t|
      t.string :name
      t.integer :limit

      t.timestamps null: false
    end
  end
end
