class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@post = current_user.posts.build
  	  @feed_items = current_user.feed.page(params[:page]).per(15)
    # else
    #   @post_link = Post.find_by(title: 'Big data introductie')
  	end
  end

  def help
  end

  def about
  end

  def pc_statement
  end

  def faq
  end 

end
