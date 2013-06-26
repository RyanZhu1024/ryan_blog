require 'spec_helper'

describe Article do
	before {@article=FactoryGirl.build(:article)}

	subject {@article}

	it {should respond_to(:title)}
	it {should respond_to(:content_link)}
	it {should respond_to(:summary)}
	it {should respond_to(:tags)}
	it {should respond_to(:comments)}

	it {should be_valid}

	describe "when title is too long,it should be invalid" do
		before do
			tempt="hello"*30;
			@article.title=tempt;
		end
		it {expect{@article.save!}.to raise_exception}
	end

	describe "when summaryis too long" do
		before do
			temps="summary"*30
			@article.summary=temps
			@article.save
		end

		it {should_not be_valid}
	end

	describe "when content_link is illegal" do
		before do
			templ="12345askjd"
			@article.content_link=templ
			@article.save
		end

		# it {should_not be_valid}
	end

	describe "when content_link is duplicated" do
		before do
			article_with_same_content_link=@article.dup
			article_with_same_content_link.save
		end
		it {should_not be_valid}
	end

	describe "corresponding comments should be deleted with the article's deletion" do
		# xit "for comments and articles"
		article_id=0
		before do
			@article.save
			@article.comments.build(receiver:FactoryGirl.create(:guest),
					sender:FactoryGirl.create(:guest),
					content:"Test Comments")
			@article.save
			article_id=@article.id
			@article.destroy
		end
		it "comments should be nil " do
			puts article_id
			expect{Comment.find_by_article_id(article_id).comments}.to raise_exception
		end
	end

	describe "corresponding tags and article relationship should be deleted by the article's deletion" do
		article_id=0
		before do
		  	@article.save
		  	@article.tags.build(name:FactoryGirl.build(:tag).name)
		  	@article.save
		  	article_id=@article.id
		  	@article.destroy
		end
		it {Tag.find_by_article_id(article_id).should be_nil}
	end

	describe "non-related tags should_not be included by the article" do
		xit "unrelated tags and articles "
	end
end
