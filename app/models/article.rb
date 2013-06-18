class Article < ActiveRecord::Base
	attr_accessible :content_link, :summary, :title
	has_many :tags
	has_many :comments,dependent: :destroy

	paginates_per 8

	VALID_CONTENT_URI_REGEX=/\.\/(\w+\/)*\w+(\.\w+)+\z/i

	validates_presence_of :content_link,:summary,:title
	validates_length_of :summary,maximum:140
	validates_length_of :title,maximum:20
	# validates_format_of :content_link,with:VALID_CONTENT_URI_REGEX,messsage:"illegal content_link"
	validates_uniqueness_of :content_link

	def addTags(tags)
		tags=tags|tags
		self.tags.destroy_all
		tags.each{|t|
			self.tags.build(name:t.to_s.downcase) 
		}
	end
end
