class JobapplicationsController < ApplicationController
	before_action :signed_in_user, only: [:index, :new, :create, :show, :edit, :update, :destroy]
	before_action :admin_user, only: [:index]
	before_action :correct_user, only: [:show]
	
  def index
  	if params[:search]
  		@jobapplications = Jobapplication.search(params[:search])
  	 else
  	 	@jobapplications = Jobapplication.all
  	 	@jobapplication = Jobapplication.first
  	 end
  end

	def new
		@jobapplication = Jobapplication.new
		@job = Job.find(params[:job_id])
	end

	def create
		@jobapplication = current_user.jobapplications.build(jobapplication_params)
		@job = Job.find_by(id: @jobapplication.job.id)
		if @jobapplication.save
			JobMailer.jobapplication_notification(@jobapplication).deliver
			flash[:success] = t(:flash_jobapplications_create)
			redirect_to jobs_path
		else
			flash[:error] = @jobapplication.errors.full_messages.to_sentence
			render :new
		end
	end

	def show
		@jobapplication = Jobapplication.find(params[:id])
	end

	private

	def jobapplication_params
		params.require(:jobapplication).permit(
			:name, :email, :content, :linkedin_url, :cv, :letter, :job_id)
	end

	def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

   def correct_user
     @jobapplication = Jobapplication.find(params[:id])
     @user = @jobapplication.job.user
     redirect_to(root_url) unless current_user?(@user) || current_user.admin?
   end
end