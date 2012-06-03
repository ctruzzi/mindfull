class RemoveXyFromEntries < ActiveRecord::Migration
	def change
		add_column :entries, :image_size, :string
		rename_column :entries, :image_url, :image
	end
end
