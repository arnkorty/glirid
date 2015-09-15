class CreateRssFeedSearches < ActiveRecord::Migration
  def change
    create_table :rss_feed_searches do |t|
      t.references :rss_feed, index: true, foreign_key: true
      t.references :search, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
