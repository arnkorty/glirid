class AddColumnsToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :name, :string
    add_column :searches, :description, :text
    add_column :searches, :options, :json, default: '{}'
    remove_column :searches, :keyword, :string
  end
end
