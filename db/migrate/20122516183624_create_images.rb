class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :first_level
      t.string :second_level
      t.string :note_level
      t.string :image_url
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
