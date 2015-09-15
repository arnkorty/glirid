class AddLastAtToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :last_at, :datetime
  end
end
