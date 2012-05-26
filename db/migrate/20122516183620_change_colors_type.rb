class ChangeColorsType < ActiveRecord::Migration
  def change
  	change_column :sections, :color, :text
  end
end
