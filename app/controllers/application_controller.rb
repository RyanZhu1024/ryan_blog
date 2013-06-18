class ApplicationController < ActionController::Base
	before_filter :show_side_bar
	after_filter :store_last_path
	protect_from_forgery

	def should_be_admin
		if session[:admin].nil?
			flash[:notice]="should be an admin"
			redirect_to root_path
		end
	end

	include ArticlesHelper

	protected
	def show_side_bar
		@show_side_bar = true
	end

	def store_last_path
		session[:last_path]=request.fullpath
	end

	def get_last_path
		unless session[:last_path].nil?
			path=session[:last_path]
			session[:last_path]=nil
			return path
		end
	end

end
