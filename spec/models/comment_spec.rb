require 'rails_helper'

describe Comment do 

	it "is valid with content" do 
		comment = Comment.new(content: "this is some content")
		expect(comment).to be_valid
	end

	it "is invalid without content" do 
		comment = Comment.new(content: nil)
		comment.valid?
		expect(comment.errors[:content]).to include("moet opgegeven zijn")

	end

	#before (@comment = user.comments.build(content: "this is a comment"))

	it { should respond_to (:content) }
end