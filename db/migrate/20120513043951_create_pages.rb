class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :userId
      t.string :title
      t.string :custom

      t.timestamps
    end
  end
end
