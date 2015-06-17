class JobpagesController < ApplicationController
	before_action :signed_in_user, only: [:jobs, :newjob, :hoteljobs, :newjobhotels]

   def pricing
    @product = Product.find(1)
   end

end
