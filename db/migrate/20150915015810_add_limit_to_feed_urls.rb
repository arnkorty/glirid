class AddLimitToFeedUrls < ActiveRecord::Migration
  def change
    add_column :feed_urls, :limit, :integer, default: 100
  end
end
