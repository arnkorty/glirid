class AddDescriptionToRssFeeds < ActiveRecord::Migration
  def change
    add_column :rss_feeds, :description, :text
  end
end
