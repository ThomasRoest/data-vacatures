class CoursesController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]
  respond_to :js, only: [:index]
  
  def index
    @courses = Course.page(params[:page]).per(9)
    if params[:sort]
      @courses = Course.where("category = ?", params[:sort])
    end
  end

  def new
  	@course = Course.new
  end

  def create
  	@course = Course.new(course_params)
  	if @course.save
  		flash[:success] = "new course added"
  		redirect_to courses_path
  	else
  		flash[:error] = "could not be saved"
  		render :new
  	end
  end

  def edit
  	@course = Course.find(params[:id])
  end

  def update
  	@course = Course.find(params[:id])
  	if @course.update(course_params)
  		flash[:success] = "course updated"
  		redirect_to courses_path
  	else
  		flash[:error] = "could not be updated"
  		render :edit
  	end
  end

  def destroy
  	Course.find(params[:id]).destroy
  	flash[:success] = 'course deleted'
  	redirect_to courses_path
  end


  private

  def course_params
  	params.require(:course).permit(:title, :description, :category, :course_url, :company)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
