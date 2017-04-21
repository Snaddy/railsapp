class PagesController < ApplicationController

	def profile
		@username = User.find(params[:id])
		@post = @username.posts
	end

end