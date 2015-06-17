class CreateUser
	def self.call(email_address)
		user = User.find_by(email: email_address)
		return user if user.present?
	end
end