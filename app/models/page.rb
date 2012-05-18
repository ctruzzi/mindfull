class Page < ActiveRecord::Base
	attr_accessible :title, :custom

	belongs_to :section
	belongs_to :user
	
	has_many :entries
end
# == Schema Information
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  title      :string(255)
#  custom     :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  section_id :string(255)
#

