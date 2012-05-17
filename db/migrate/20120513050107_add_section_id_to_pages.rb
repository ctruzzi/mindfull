class AddSectionIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :section_id, :string

  end
end
