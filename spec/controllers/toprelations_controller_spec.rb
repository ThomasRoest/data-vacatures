# require 'spec_helper'

# describe ToprelationsController do

#   let(:user) { FactoryGirl.create(:user) }
#   let(:other_topic) { FactoryGirl.create(:topic) }

#   before { sign_in user }

#   describe "creating a toprelation with Ajax" do

#     it "should increment the toprelation count" do
#       expect do
#         xhr :post, :create, toprelation: { topic_followed_id: other_topic.id }
#       end.to change(Toprelation, :count).by(1)
#     end

#     it "should respond with success" do
#       xhr :post, :create, toprelation: { topic_followed_id: other_topic.id }
#       expect(response).to be_success
#     end
#   end

#   describe "destroying a toprelationship with Ajax" do

#     before { user.topic_follow!(other_topic) }
#     let(:toprelation) do
#       user.toprelations.find_by(topic_followed_id: other_topic.id)
#     end

#     it "should decrement the toprelation count" do
#       expect do
#         xhr :delete, :destroy, id: toprelation.id
#       end.to change(Toprelation, :count).by(-1)
#     end

#     it "should respond with success" do
#       xhr :delete, :destroy, id: toprelation.id
#       expect(response).to be_success
#     end
#   end
# end