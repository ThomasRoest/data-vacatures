class CommentsController < ApplicationController
	before_action :signed_in_user
	before_action :correct_user,   only: [:edit, :update, :destroy]
	
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @post.save
			flash[:success] = t(:flash_comments_create)
			redirect_to @post
		else
			flash[:error] = (:flash_comments_error)
			render :new
		end
	end

	def edit
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def update
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
			if @comment.update_attributes(comment_params)
    	 		flash[:success] = t(:flash_comments_update)
      			redirect_to @post
    		else
      			render 'edit'
    		end
  	end

	def destroy
		@post = Post.find(params[:post_id])
		if @comment.destroy
			flash[:success] = t(:flash_comments_destroy)
			redirect_to @post
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :post_id, :user_id)
	end

	def correct_user
		@comment = current_user.comments.find_by(id: params[:id])
		redirect_to root_url if @comment.nil?
	end
end
