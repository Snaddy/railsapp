class Api::V1::SearchesController < ActionController::Base

	def search
		@results = User.search(params[:search])
		render json: @results
	end

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