class Api::V1::AccountsController < ActionController::Base

	def reset_password
		@user = User.find_by(email: params[:email])
		if User.exists?(email: params[:email])
			@user.send_reset_password_instructions
			render json: {message: 'success'}
		else
			render json: {message: 'email does not exists'}
		end
	end
end