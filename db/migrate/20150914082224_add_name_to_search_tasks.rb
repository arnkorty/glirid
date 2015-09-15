class AddNameToSearchTasks < ActiveRecord::Migration
  def change
    add_column :search_tasks, :name, :string
  end
end
