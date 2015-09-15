class AddWorkIdToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :current_work_id, :string
    add_column :searches, :next_work_id, :string
    add_column :searches, :next_at, :datetime
  end
end
