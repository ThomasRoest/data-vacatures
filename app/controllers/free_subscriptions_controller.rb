class FreeSubscriptionsController < ApplicationController

  def new
    # @free_subscription = FreeSubscription.new
  end

  def create
    # @free_subscription = FreeSubscription.new
    @free_subscription = FreeSubscription.create
    if @free_subscription.save
      redirect_to freejob_path(guid: @free_subscription.guid)
    end
  end
end
