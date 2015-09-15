class AddFrequencyToSearchTasks < ActiveRecord::Migration
  def change
    remove_column :search_tasks, :frequency
    add_reference :search_tasks, :frequency, index: true, foreign_key: true
  end
end
