class Page < ActiveRecord::Base
	attr_accessible :title, :custom, :section_id

	belongs_to :section, :class_name => "Section", :foreign_key => "section_id"
	belongs_to :user, :class_name => "User", :foreign_key => "user_id"
	
	has_many :entries

	validates :user_id,	:presence => true
	validates :title,	:presence => true
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
#  section_id :integer(255)
#

