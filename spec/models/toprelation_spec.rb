require 'spec_helper'

describe Toprelation do
	let(:topic_follower) { FactoryGirl.create(:user) }
	let(:topic_followed) { FactoryGirl.create(:topic) }
	let(:toprelation) { topic_follower.toprelations.build(topic_followed_id: topic_followed.id) }

	subject { toprelation }

	it { should be_valid }

	describe "topic follower methods" do
		it { should respond_to (:topic_follower) }
		it { should respond_to (:topic_followed) }
		its(:topic_follower) { should eq topic_follower }
		its(:topic_followed) { should eq topic_followed }
	end

	describe "when followed id is not present" do
    	before { toprelation.topic_followed_id = nil }
    	it { should_not be_valid }
  	end

  	describe "when follower id is not present" do
    	before { toprelation.topic_follower_id = nil }
    	it { should_not be_valid }
  	end

end
