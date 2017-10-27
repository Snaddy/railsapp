class Api::V1::PagesController < ApplicationController

before_action :authenticate_user!

	def profile
		@user = User.find_by(id: params[:id])
		render 'pages/profile'
	end

	def get_user_posts
		@user = User.find_by(id: params[:id])
		if !@user.blocking?(current_user)
			@posts = @user.posts.paginate(page: params[:page], per_page: 15).order('created_at DESC')
		end
		render 'pages/get_user_posts'
	end

	def self
		@user = current_user
		@posts = @user.posts.paginate(page: params[:page], per_page: 15).order('created_at DESC')
		render 'pages/self'
	end

	def get_self_posts
		@user = current_user
		@posts = @user.posts.paginate(page: params[:page], per_page: 15).order('created_at DESC')
		render 'pages/get_self_posts'
	end

	def search
		@results = User.search(params[:search]).limit(20)
		render 'pages/search'
	end

end