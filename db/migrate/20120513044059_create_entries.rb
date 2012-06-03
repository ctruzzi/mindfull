class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :page_id
      t.string :text
      t.string :image_url
      t.string :custom_css

      t.timestamps
    end
  end
end
