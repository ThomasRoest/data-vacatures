class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update]
  before_action :signed_in_user
  before_action :admin_user, only: [:index, :show]

 
  def index
    @sales = Sale.all
  end

 
  def show
     @sale = Sale.find(params[:id])
  end

 
  def new
    @sale = Sale.new
  end

 
  def edit
  end

  
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

 
  def destroy  
    @sale = Sale.find(params[:id]) 
      destroy_job
      destroy_customer
      ReceiptMailer.confirm_delete(@sale).deliver
        respond_to do |format|
          flash[:success] = t(:flash_jobs_delete)
          format.html { redirect_to user_path(current_user) }
          format.json { head :no_content }
        end
  end

   
  

  private
  
    def set_sale
      @sale = Sale.find(params[:id])
    end

    def sale_params
      params.require(:sale).permit(:email, :guid, :product_id)
    end

     def admin_user
        redirect_to(root_url) unless current_user.admin?
    end

    def destroy_job
       if @job = Job.where("guid =?", @sale.guid).exists?
          @job = Job.where("guid =?", @sale.guid)
          Job.destroy(@job)
       end
    end

    def destroy_customer
      customer = Stripe::Customer.retrieve(@sale.stripe_id)
      customer.delete
      @sale.destroy
    end
end
