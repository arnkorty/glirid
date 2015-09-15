class AddJobIdToSearchTasks < ActiveRecord::Migration
  def change
    add_column :search_tasks, :job_id, :string
  end
end
