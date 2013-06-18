require 'spec_helper'

describe Tag do
	let(:article){FactoryGirl.create(:article)}
	before do
		@tag=article.tags.build(name:"first tag")
		@tag.save
	end

	subject{@tag}

	it{should respond_to(:name)}
	it{should respond_to(:articles)}

	describe "create a Tag" do
		before do
			temptag=@tag.dup
			temptag.save
		end
		it{should be_valid}
	end
end
