class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :pageId
      t.string :text
      t.string :imageUrl
      t.string :customCss
      t.integer :xcoord
      t.integer :ycoord

      t.timestamps
    end
  end
end
