class AddOpenToFeedUrls < ActiveRecord::Migration
  def change
    add_column :feed_urls, :open, :boolean, default: true
    add_column :feed_urls, :collect_num, :integer
  end
end
