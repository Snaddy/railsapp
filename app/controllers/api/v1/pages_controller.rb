class Api::V1::PagesController < ApplicationController

before_action :authenticate_user!

	def profile
		@user = User.find_by(id: params[:id])
		@posts = @user.posts.order('created_at DESC')
		render 'pages/profile'
	end

	def self
		@user = current_user
		@posts = @user.posts.order('created_at DESC')
		render 'pages/self'
	end

	def search
		@results = User.search(params[:search]).limit(20)
		render 'pages/search'
	end

end