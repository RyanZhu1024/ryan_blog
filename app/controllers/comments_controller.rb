class CommentsController < ApplicationController


	def create
		@article=Article.find_by_id(params[:comment][:article_id])
		respond_to do |format|
			unless @article.nil?
				content=params[:comment][:content]
				receiver=Guest.find_by_name(params[:receiver_name])
				sender=Guest.find_by_email(params[:sender_email])||Guest.create(email:params[:sender_email],name:params[:sender_name])
				@comment=@article.comments.new(content:content,receiver:receiver,sender:sender)

				begin
					@comment.save
					format.html {redirect_to @article}
					format.js {render :layout=>false}
				rescue Exception => e
					@comment=nil
					format.html {redirect_to @article}
					format.js {render :layout=>false}
				end

			else
				flash[:error]="Article not found"
				format.html {redirect_to @article}
				format.js {render :layout=>false,:status=>404}
			end
		end
	end

	def destroy

	end

	def update

	end

	def index
		respond_to do |format|
			begin
				@comments=Article.find_by_id(params[:article_id]).comments
				require 'commentresponse'
				comment_response=[]

				@comments.each{|comment| 
					temp=CommentResponse.new
					temp.comment=comment
					temp.sender_email=comment.sender.email
					temp.sender_name=comment.sender.name
					comment_response.push(temp)
				}
				format.json {render :json=>comment_response,layout:false}
			rescue Exception => e
				flash[:error]="Not found"+e.message
				format.js {render :json=>nil,layout:false,:status=>404}
			end
		end
	end

	def edit

	end
end
