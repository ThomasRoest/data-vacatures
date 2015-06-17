
class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :correct_user,   only: [:edit, :update, :destroy]

	def index
    @topics = Topic.all
    if params[:topic]
      @posts = Post.where(topic: params[:topic]).page(params[:page]).per(15)
    else
      @posts = Post.all.page(params[:page]).per(15)
    end
	end

	def search
		if params[:search].empty?
			@posts = []
		else
			@posts = Post.search(params[:search])
		end 
	end

	def new
		@post = Post.new
	end
	
	def create
		@post = current_user.posts.build(post_params)
		# bitly_shorten	
		if @post.save
			flash[:success] = t(:flash_posts_create)
			redirect_to @post
		else
			@feed_items = []
			render :new
			# flash[:error] = "controleer het formulier op fouten"
		end
	end

	def destroy
		if @post.destroy
			flash[:success] = t(:flash_posts_destroy)
			redirect_to root_url
		end
	end

	def show
		 @post = Post.find(params[:id])
		 @comment = @post.comments
	end

	def edit
		@post = Post.find(params[:id])
		@post.embed_url = @post.video_url
	end

	def update
		@post = Post.find(params[:id])
			if @post.update_attributes(post_params)
    	 		flash[:success] = t(:flash_posts_update)
      			redirect_to @post
    		else
      			render 'edit'
      			flash.now[:error] = @post.errors.full_messages.to_sentence
    		end
  	end

	private

		def post_params
			params.require(:post).permit(:title, :content, :topic_id, :video_url, :embed_url, :markdown)
		end

		def correct_user
			@post = current_user.posts.find_by(id: params[:id])
			redirect_to root_url if @post.nil?
		end

		def admin_user
      		redirect_to(root_url) unless current_user.admin?
    	end

		def bitly_shorten
     		client = Bitly.client 
     		urls = URI.extract(@post.content) 
     		urls.each do |url|
       		  @post.content.gsub!(url, client.shorten(url).short_url) 
     		end
   	end
end