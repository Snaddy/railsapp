class Api::V1::AccountsController < ApplicationController

	def reset_password(email)
		@user = User.find_by[email: email]
		@user.send_reset_password_instructions
	end

end