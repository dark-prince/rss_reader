class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url
      t.string :feed_url
      t.text :description
      t.timestamps
    end
  end
end