class CommentResponse
	def sender_name=(name)
		@sender_name=name
	end

	def sender_email=(email)
		@sender_email=email
	end

	def comment=(com)
		@comment=com
	end

	def sender_name
		@sender_name
	end

	def sender_email
		@sender_email
	end

	def comment
		@comment
	end
end