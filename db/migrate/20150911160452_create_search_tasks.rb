class CreateSearchTasks < ActiveRecord::Migration
  def change
    create_table :search_tasks do |t|
      t.references :search, index: true, foreign_key: true
      t.integer :frequency
      t.datetime :begin_at

      t.timestamps null: false
    end
  end
end
