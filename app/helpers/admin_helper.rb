module AdminHelper
	def admin?
		admin=Admin.find_by_name(params[:name]).try(:authenticate, params[:password])
		admin.nil?
	end
end
