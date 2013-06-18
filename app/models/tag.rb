class Tag < ActiveRecord::Base
	attr_accessible :name

	validates_presence_of :name,:article_id
	validates_length_of :name,maximum:20

end
