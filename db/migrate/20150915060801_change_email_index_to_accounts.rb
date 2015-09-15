class ChangeEmailIndexToAccounts < ActiveRecord::Migration
  def change
    remove_index :accounts, :email#, unique: true
    add_index :accounts, :email
  end
end
