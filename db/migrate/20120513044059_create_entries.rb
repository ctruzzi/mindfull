class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :page_id
      t.string :text
      t.string :image_url
      t.string :custom_css
      t.integer :xcoord
      t.integer :ycoord

      t.timestamps
    end
  end
end
