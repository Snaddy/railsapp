class Api::V1::PagesController < ApplicationController

before_action :authenticate_user!

	def profile
		@user = User.find_by(id: params[:id])
		@posts = @user.posts
		render 'pages/profile'
	end

	def search
		@results = User.search(params[:search])
		render @results
	end

end