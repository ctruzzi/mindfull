class CreatePageCanvas < ActiveRecord::Migration
  def change
    create_table :page_canvas do |t|

      t.timestamps
    end
  end
end
