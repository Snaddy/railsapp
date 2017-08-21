class Api::V1::AccountsController < ApplicationController

	skip_before_action :configure_devise_permitted_parameters

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