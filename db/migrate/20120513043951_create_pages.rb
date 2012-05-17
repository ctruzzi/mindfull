class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :user_id
      t.string :title
      t.string :custom

      t.timestamps
    end
  end
end
