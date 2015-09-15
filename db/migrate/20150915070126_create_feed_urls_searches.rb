class CreateFeedUrlsSearches < ActiveRecord::Migration
  def change
    create_table :feed_urls_searches do |t|
      t.references :feed_url, index: true, foreign_key: true
      t.references :search, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
