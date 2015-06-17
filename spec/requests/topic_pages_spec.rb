require 'spec_helper'

describe "TopicPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	
	describe "topic follow/topic unfollow buttons" do
		
      let(:other_topic) { FactoryGirl.create(:topic) }
      before { sign_in user }

      describe "following a topic" do
        before { visit topic_path(other_topic) }

        it "should increment the followed topic count" do
          expect do
            click_button "Volg dit onderwerp"
          end.to change(user.followed_topics, :count).by(1)
        end

        it "should increment the other topics followers count" do
          expect do
            click_button "Volg dit onderwerp"
          end.to change(other_topic.topic_followers, :count).by(1)
        end

      #   describe "toggling the button" do
      #     before { click_button "Follow this topic" }
      #     it { should have_xpath('//input[@value="Unfollow this Topic"]') }
      #   end
       end

      describe "unfollowing a topic" do
        before do
          user.topic_follow!(other_topic)
          visit topic_path(other_topic)
        end

        it "should decrement the followed topic count" do
          expect do
            click_button "Niet meer volgen"
          end.to change(user.followed_topics, :count).by(-1)
        end

        it "should decrement the other topucs's followers count" do
          expect do
            click_button "Niet meer volgen"
          end.to change(other_topic.topic_followers, :count).by(-1)
        end

        # describe "toggling the button" do
        #   before { click_button "Unfollow this topic" }
        #   it { should have_xpath("//input[@value='Follow this topic']") }
        # end
       
       end #end unfollow
    end #end follow/unfollow

 
end
