class AddRssTokenToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :rss_token, :string
  end
end
