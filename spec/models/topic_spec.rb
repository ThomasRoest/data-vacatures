 require 'spec_helper'

 describe Topic do

 	 before do
	  @topic = Topic.new(name: "Hotels") 
	  @user = User.new(name: "Example User", email: "user@example.com",
	   				   password: "foobar", password_confirmation: "foobar") 
	 end

	subject { @topic }

 	it { should respond_to(:toprelations) }
 	it { should respond_to(:reverse_toprelations)}
 	it { should respond_to(:topic_followers) }


  describe "topic followers" do
        let(:other_topic) { FactoryGirl.create(:topic) }
        before do
          @user.save
          @user.topic_follow!(other_topic)
          end
        subject { other_topic }
        its(:topic_followers) { should include(@user) }
        
    end 
end

