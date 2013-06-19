class ArticlesController < ApplicationController

	skip_before_filter :show_side_bar,only:[:new,:edit]

	def create
		create_or_update_article
	end

	def update
		create_or_update_article
	end

	def edit
		@article=Article.find_by_id params[:id]
		@content=File.read(@article.content_link)
	end

	def destroy
		@article=Article.find_by_id params[:id]
		begin
			unless @article.nil?
				file_path=@article.content_link
				File.delete(file_path) if File.exists? file_path
				@article.destroy 
				flash[:notice]="Blog deleted"
			else
				flash[:warn]="Blog not existed,delete the data anyway!"
			end
			redirect_to articles_path
		rescue Exception => e
			flash[:error]="Blog deleted failed because of "+e.message
			redirect_to @article
		end
	end

	def index
		@articles = Article.order("created_at DESC").page params[:page]
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
			@articles=Article.joins(:tags).where('tags.name'=>tag_name).uniq.order("created_at DESC").page params[:page]
		else
			flash.now[:warn]='not such tag for '+tag_name
		end
		render :index
	end

	def create_or_update_article
		title=params[:title]
		content=params[:content]
		tags=params[:tags]
		summary=content[0..139]
		file_name=title+'-'+Time.now.asctime.split.join('-')
		file_path='./blogs/'+file_name+'.md'

		@article=Article.find_by_id(params[:id])||Article.new()
		update=(@article.id.blank?)? false:true

		begin
			@article.title=title
			@article.content_link=file_path unless update
			@article.summary=summary
			@article.save!
			@article.addTags(tags.split(' '))
			@article.save!
			File.open(@article.content_link,'w+'){|f|
				f.write content
			}
			unless update
				flash[:notice]="Blog posted"
			else
				flash[:notice]="Blog updated"
			end
		rescue Exception => e
			raise e
			flash[:error]="#{@article.title},#{@article.content},#{@article.content_link},#{e.message}"
			unless update
				redirect_to new_article_path
			else
				redirect_to edit_article_path @article
			end
			return
		end
		redirect_to @article
	end
end
