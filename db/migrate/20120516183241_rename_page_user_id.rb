class RenamePageUserId < ActiveRecord::Migration
  def up
  	rename_column :pages, :userId, :user_id
  end

  def down
  end
end
