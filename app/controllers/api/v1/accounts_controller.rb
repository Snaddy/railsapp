class Api::V1::AccountsController < ApplicationController

	def reset_password
		@user = User.find_by(email: params[:email])
		@user.send_reset_password_instructions
	end

end