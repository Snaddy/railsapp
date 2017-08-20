class Api::V1::PagesController < ApplicationController

#before_action :authenticate_user!, :except => [:reset_password]

	def profile
		@user = User.find_by(id: params[:id])
		@posts = @user.posts
		render 'pages/profile'
	end

	def self
		@user = current_user
		@posts = @user.posts
		render 'pages/self'
	end

	def search
		@results = User.search(params[:search])
		render json: @results
	end

	def reset_password
		@user = current_user
		@user.send_reset_password_instructions
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