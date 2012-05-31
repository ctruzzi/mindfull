class AddOptionalImagesColumn < ActiveRecord::Migration
  def change
  	add_column :entries, :optional_images, :string
  end

  def down
  end
end
