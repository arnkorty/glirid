class ChangeOpenToFeedUrls < ActiveRecord::Migration
  def change
    rename_column :feed_urls, :open, :is_open
  end
end
