require 'spec_helper'

describe ApplicationController do
	controller do
		def index
			should_be_admin
		end
	end

	it "should redirect to root_path" do
		get :index
		expect(response).to redirect_to root_path
	end

end
