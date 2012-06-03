# == Schema Information
#
# Table name: images
#
#  id           :integer         not null, primary key
#  first_level  :string(255)
#  second_level :string(255)
#  image_url    :string(255)
#  x            :integer
#  y            :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#
class Image < ActiveRecord::Base
	DEFAULT_SUB_DIRECTORY = "entry_images/"
	def imageString
		"#{DEFAULT_SUB_DIRECTORY}#{first_level}/#{second_level}/#{image_url}"
	end
end

