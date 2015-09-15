class AddAccountIdToSearches < ActiveRecord::Migration
  def change
    add_reference :searches, :account, index: true, foreign_key: true
  end
end
