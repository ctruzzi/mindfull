# == Schema Information
#
# Table name: sections
#
#  id         :integer         not null, primary key
#  clazz_id   :integer
#  color      :text(255)
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Section < ActiveRecord::Base
	attr_accessible :color, :title

	belongs_to :clazz, :class_name => "Clazz", :foreign_key => "clazz_id"
	has_many :pages

	validates :clazz_id,	:presence => true
	validates :title,		:presence => true

	COLORS = [{:color => "#EE5F33", :h_color => "#943820"}, 
		{:color => "#F6AD4E", :h_color => "#B37A1E"}, 
		{:color => "#80C152", :h_color => "#59873A"}, 
		{:color => "#3AA7B6", :h_color => "#287580"}, 
		{:color => "#EB3577", :h_color => "#96224C"}]

	def self.getColor(value) 
		if value > COLORS.size 
			COLORS[value]
		else
			COLORS[value % COLORS.size]
		end
	end

end

