require 'spec_helper'

describe Post do 

	let(:user) { FactoryGirl.create(:user) }
	let(:topic) { FactoryGirl.create(:topic) }
	before { @post = user.posts.build(title: "this is a title", content: "Lorem Ipsum", topic_id: topic.id) }

	subject { @post }

	it { should respond_to (:title) }
	it { should respond_to (:content) }
	it { should respond_to (:user_id ) }
	it { should respond_to (:topic_id) }
	it { should respond_to (:topic) }
	it { should respond_to (:user) }
	# its(:user) { should eq user }

	it { should be_valid }

	describe "when user_id is not present"  do
		before { @post.user_id = nil }
		it { should_not be_valid }
	end

	describe "when topic_id is not present" do 
		before { @post.topic_id = nil }
		it { should_not be_valid }
	end

	
	#with invalid embedly url
	# should not be valid
	# reponse code testing?
	
end