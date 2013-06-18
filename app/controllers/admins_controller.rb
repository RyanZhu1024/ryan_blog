class AdminsController < ApplicationController

	before_filter :should_be_admin,only:[:log_out,:edit,:update]
	before_filter :admin_logged_in,only:[:log_in,:sign_in]

	def log_in
		admin=Admin.find_by_name(params[:admin][:name])
		unless admin.nil?
			admin=admin.authenticate(params[:admin][:password])
			if admin==false
				# wrong password,login again
				redirect_to sign_in_admins_path
			else
				session[:admin]=admin.name
				redirect_to root_path
			end
		else
			redirect_to sign_in_admins_path
		end
	end

	def log_out
		session[:admin]=nil
		# render :nothing=>true	#only for test
		# redirect_to root_path
		redirect_to sign_in_admins_path
	end

	#edit admin info,a.k.a myself
	def edit
		
	end

	#update the new info
	def update
		
	end

	#for sign_in page use
	def sign_in
		@admin=Admin.new
	end

	private
	def admin_logged_in
		reset_session
		redirect_to root_path if session[:admin]=="ryan"
	end
end
