class Api::V1::AccountsController < ApplicationController

prepend_before_action :require_no_authentication

	def reset_password
		@user = User.find_by(email: params[:email])
		if @user.exists?
			@user.send_reset_password_instructions
			render json: {message: 'success'}
		else
			render json: {message: 'email does not exists'}
		end
	end
end