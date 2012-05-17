class AddSectionIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sectionId, :string

  end
end
