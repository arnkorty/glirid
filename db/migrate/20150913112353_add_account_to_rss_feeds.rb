class AddAccountToRssFeeds < ActiveRecord::Migration
  def change
    add_reference :rss_feeds, :account, index: true, foreign_key: true
  end
end
