class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :clazz_id
      t.string :color
      t.string :title

      t.timestamps
    end
  end
end
