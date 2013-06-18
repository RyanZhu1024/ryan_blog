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
			tempt="hello"*10;
			@article.title=tempt;
			@article.save
		end
		it {should_not be_valid}
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

		it {should_not be_valid}
	end

	describe "when content_link is duplicated" do
		before do
			article_with_same_content_link=@article.dup
			article_with_same_content_link.save
		end
		it {should_not be_valid}
	end

	describe "corresponding comments should be deleted with the article's deletion" do
		xit "for comments and articles"
	end

	describe "corresponding tags should not be deleted by the article's deletion" do
		xit "for tags and articles when delete"
	end

	describe "non-related tags should_not be included by the article" do
		xit "unrelated tags and articles "
	end
end
