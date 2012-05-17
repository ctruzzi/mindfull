class RenameClassIdToClazzId < ActiveRecord::Migration
  def up
  	rename_column :sections, :class_id, :clazz_id
  end

  def down
  end
end
