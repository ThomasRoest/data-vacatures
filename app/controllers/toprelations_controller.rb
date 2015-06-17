class ToprelationsController < ApplicationController
	before_action :signed_in_user

	def create
		@topic = Topic.find(params[:toprelation][:topic_followed_id])
		current_user.topic_follow!(@topic)
		respond_to do |format| 
			format.html { redirect_to @topic }
			format.js
		end
	end

	def destroy
		#Rails.logger.debug 'DEBUG: FINDING THE TOPRELATION --------------'
		@topic = Toprelation.find(params[:id]).topic_followed
		 current_user.topic_unfollow!(@topic)
		 respond_to do |format|
		 	format.html { redirect_to @topic }
		 	format.js
		 end
	end
end
