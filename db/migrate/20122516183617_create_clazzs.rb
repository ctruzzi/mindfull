class CreateClazzs < ActiveRecord::Migration
  def change
    create_table :clazzs do |t|
      t.string :name
      t.string :user_id

      t.timestamps
    end
  end
end
