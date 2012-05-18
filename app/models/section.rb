# == Schema Information
#
# Table name: sections
#
#  id         :integer         not null, primary key
#  clazz_id   :integer
#  color      :string(255)
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Section < ActiveRecord::Base
	attr_accessible :color, :title

	belongs_to :clazzs
	has_many :pages

	validates :clazz_id,	:presence => true
	validates :title,		:presence => true
end

