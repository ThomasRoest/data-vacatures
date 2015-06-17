class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    #Rails.logger.debug 'CURRENT USER.UNFOLLOW METHOD --------------------'
    current_user.unfollow!(@user)
    #Rails.logger.debug 'AJAX FUNCTIONALITY --------------------'
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end