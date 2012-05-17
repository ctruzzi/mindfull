class ChangeColumnNames < ActiveRecord::Migration
  def up
  	rename_column :entries, :customCss, :custom_css
  	rename_column :pages, :sectionId, :section_id
  end

  def down
  end
end
