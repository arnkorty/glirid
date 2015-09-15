class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :search, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true
      t.string :title
      t.string :url
      t.string :domain
      t.text :description
      t.datetime :task_at

      t.timestamps null: false
    end
  end
end
