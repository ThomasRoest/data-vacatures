class TopicsController < ApplicationController
before_action :signed_in_user, only: [:topic_followers]
before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]


	def index
		@topics = Topic.order(id: :desc)
	end

	def show
		@topic = Topic.find(params[:id])
    @posts = @topic.posts.page(params[:page]).per(15)
	end

  def new
    @topic = Topic.new
  end

	def create
  		@topic = Topic.new(topic_params)
  		if @topic.save
        flash[:success] = t(:flash_topics_create)
  			redirect_to @topic
  		else
  			render 'new'
  		end
  	end

    def edit
      @topic = Topic.find(params[:id])
    end

    def update
      @topic = Topic.find(params[:id])
      @topic.update_attributes(edit_topic_params)
      redirect_to @topic
    end

  	def destroy
  	end

     def topic_followers
      @title = "Topic Followers"
      @topic = Topic.find(params[:id])
      @topics = @topic.topic_followers.page(params[:page])
      render 'show_topic_follow'
    end

  	private

  	def topic_params
  		params.require(:topic).permit(:name, :id, :avatar)
  	end

    def edit_topic_params
      params.require(:topic).permit(:name, :avatar)
    end

    def admin_user
        redirect_to(root_url) unless current_user.admin?
    end
end
