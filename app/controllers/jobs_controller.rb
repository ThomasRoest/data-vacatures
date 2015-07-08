class JobsController < ApplicationController 
	 before_action :signed_in_user, only: [:new, :create, :create_free, :edit, :update, :destroy]
	 before_action :correct_user, only: [:edit, :destroy]
	 before_action :check_guid, only: [:new]
   before_action :check_free_guid, only: [:new_free, :create_free]
   before_action :check_free_job, only: [:new_free, :create_free]
   before_action :signup_redirect, only: [:new_free]
	
	def index
		@jobs = Job.all
	end

  def new_free
    @job = Job.new
  end

	def new
		@job = Job.new
	end

	def create
		@job = current_user.jobs.build(job_params)
		if @job.save
			flash[:success] = t(:flash_jobs_create)
			redirect_to @job
		else
			flash.now[:error] = @job.errors.full_messages.to_sentence
			@subscription = Subscription.find_by!(guid: @job.guid)
			render 'new'
		end
	end

  def create_free
    @job = current_user.jobs.build(job_params)
    @job.guid = params[:guid]
    @job.free = true

    if @job.save
      flash[:success] = t(:flash_jobs_create)
      redirect_to @job
    else
      flash.now[:error] = @job.errors.full_messages.to_sentence
      render 'new_free'
    end
  end

	def show
		@job = Job.find(params[:id])
	end

	def edit
		@job = Job.find(params[:id])
	end

	def update
		@job = Job.find(params[:id])
		if @job.update_attributes(job_params)
			flash[:success] = t(:flash_jobs_update)
			redirect_to @job
		else 
			flash.now[:error] = @job.errors.full_messages.to_sentence
			render 'edit'
		end
	end

 # alleen voor gratis vacatures!
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    @free_subscription = FreeSubscription.find_by(guid: @job.guid).destroy
    flash[:success] = "vacature verwijderd"
    redirect_to mijn_vacatures_user_path(@job.user)
  end

	private

	def job_params
		params.require(:job).permit(:company, 
			  :place, :title, :directapply, :description, 
			  :email, :avatar, :guid, :link, :markdown, :summary, :job_type, :free)
	end

	def correct_user
		@job = Job.find(params[:id])
    @user = User.find_by(id: @job.user_id)
    redirect_to(root_url) unless current_user?(@user)
  end

  def check_guid
    @subscription = Subscription.find_by!(guid: params[:guid])
    unless @subscription.finished? 
      redirect_to root_url
      flash[:error] = "Deze link is niet geldig"
    end
  end

  def check_free_guid
    unless FreeSubscription.where(guid: params[:guid]).exists?
      flash[:error] = "Deze link is niet geldig"
      redirect_to jobs_path
    end
  end

  def check_free_job
    if Job.where(guid: params[:guid]).exists?
      flash[:error] = "Deze link is niet geldig"
      redirect_to jobs_path
    end
  end

  def signup_redirect
    unless signed_in?
      redirect_to signup_path
    end
  end
end