module ArticlesHelper
	def render_markdown(content)
		require 'redcarpet'
		renderer = PygmentizeHTML.new(hard_wrap:true)
		extensions = {
			fenced_code_blocks:true,
			autolink:true,
			# hard_wrap:true,
			filter_html:true,
			no_intra_emphasis:true,
			gh_blockcode:true
		}
		redcarpet = Redcarpet::Markdown.new(renderer, extensions)
		redcarpet.render content.html_safe
	end

	class PygmentizeHTML < Redcarpet::Render::HTML
		def block_code(code, language)
			require 'pygmentize'
			Pygmentize.process(code, language)
		end
	end

	def getAllTags
		Tag.select(:name).uniq
	end

	def fill_in_tags(article)
		tags=[]
		article.tags.each do |tag|
			tags<<tag.name
		end
		tags.join(' ')
	end
end
