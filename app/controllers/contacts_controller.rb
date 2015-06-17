class ContactsController < ApplicationController
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(secure_params)
		if @contact.valid?
			UserMailer.contact_email(@contact).deliver
			flash[:success] = t(:flash_contacts_new)
			redirect_to jobs_path
		else
			render :new
		end
	end

	private

	def secure_params
		params.require(:contact).permit(:name, :email, :content)
	end
end