class Api::V1::SearchesController < ActionController::Base

	def username_search
		@result = User.username_exists?(params[:username_search])
		render json: {
			status: @result
		}
	end

	def email_search
		@result = User.email_exists?(params[:email_search])
		render json: {
			status: @result
		}
	end
end