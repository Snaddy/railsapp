class Api::V1::PagesController < ApplicationController

before_filter :authenticate_user!

	def profile
		@username = User.find(params[:id])
		@posts = @username.posts
		respond_to do |format|
      		format.json do
        		render :json => @posts.to_json(methods: [:get_likes_count, :time_create_at], include: { user: { only: :username } })
      		end
    	end
	end

	def search
		@results = User.search(params[:search])
		render @results
	end

end