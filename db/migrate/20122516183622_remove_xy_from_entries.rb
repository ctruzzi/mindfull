class RemoveXyFromEntries < ActiveRecord::Migration
	def change
		add_column :entries, :image_size, :string
		remove_column :entries, :xcoord
		remove_column :entries, :ycoord
		rename_column :entries, :image_url, :image
	end
end
