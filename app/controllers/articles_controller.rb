class ArticlesController < ApplicationController

	skip_before_filter :show_side_bar,only:[:new]

	def create
		title=params[:title]
		content=params[:content]
		tags=params[:tags]
		summary=content[0..139]
		file_name=title+'-'+Time.now.asctime.split.join('-')
		file_path='./blogs/'+file_name+'.md'

		@article=Article.new(title:title,content_link:file_path,summary:summary)

		begin
			@article.save!
			@article.addTags(tags.split(' '))
			@article.save!
			File.open(file_path,'w+'){|f|
				f.write content
			}
			flash[:notice]="Blog posted"
		rescue Exception => e
			raise e
			flash[:error]="#{title},#{content},#{file_path},#{e.message}"
			redirect_to new_article_path
			return
		end
		@content=content
		@title=title
		redirect_to @article
	end

	def update

	end

	def edit

	end

	def destroy

	end

	def index
		@articles=Article.all
	end

	def new
		@article=Article.new
	end

	def show
		@article=Article.find_by_id(params[:id])
		unless @article.nil?
			@content=File.read(@article.content_link)
		else
			flash.now.alert="No article found"
		end
	end

	def getTags
		tags=getAllTags
		respond_to do |format|
			format.js {render :json=>tags,layout:false}
		end
	end

	def getArticlesByTag
		tag_name=params[:tag].to_s.downcase
		if Tag.exists?(:name=>tag_name)
			@articles=Article.joins(:tags).where('tags.name'=>tag_name).uniq
		else
			flash.now[:warn]='not such tag for '+tag_name
		end
		render :index
	end
end
