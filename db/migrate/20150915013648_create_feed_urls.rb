class CreateFeedUrls < ActiveRecord::Migration
  def change
    create_table :feed_urls do |t|
      t.string :name
      t.text :description
      t.references :account, index: true, foreign_key: true
      t.string :token

      t.timestamps null: false
    end
  end
end
