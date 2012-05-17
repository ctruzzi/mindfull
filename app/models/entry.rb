# == Schema Information
#
# Table name: entries
#
#  id         :integer         not null, primary key
#  page_id    :integer
#  text       :string(255)
#  image_url  :string(255)
#  custom_css :string(255)
#  xcoord     :integer
#  ycoord     :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#


class Entry < ActiveRecord::Base
	attr_accessible :text, :image_url, :custom_css, :xcoord, :ycoord

	belongs_to :pages
end

