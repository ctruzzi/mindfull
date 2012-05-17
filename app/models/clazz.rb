# == Schema Information
#
# Table name: clazzs
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
class Clazz < ActiveRecord::Base
	attr_accessible :name

	belongs_to :users
	has_many :sections

	validates :name,	:presence => true
end

# == Schema Information
#
# Table name: clazzs
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

