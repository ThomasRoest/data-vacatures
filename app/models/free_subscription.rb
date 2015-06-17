class FreeSubscription < ActiveRecord::Base
  before_create :populate_guid

  def populate_guid
    self.guid = SecureRandom.uuid()
  end
end
