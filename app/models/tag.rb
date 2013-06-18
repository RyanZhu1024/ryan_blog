class Tag < ActiveRecord::Base
	before_save :to_downcase

	attr_accessible :name

	validates_presence_of :name,:article_id
	validates_length_of :name,maximum:20

	def to_downcase
		self.name.downcase
	end

end
