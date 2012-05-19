class AddRandomColumnFucker < ActiveRecord::Migration
  def change
  	change_column :pages, :section_id, :integer
  end
end
