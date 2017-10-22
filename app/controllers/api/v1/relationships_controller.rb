class Api::V1::RelationshipsController < ApplicationController

	before_action :authenticate_user!

def create
	@user = User.find_by(id: params[:id])
	current_user.follow!(@user)
	render json: {status: "followed"}
end

def destroy
	@user = User.find_by(id: params[:id])
	current_user.unfollow!(@user)
	render json: {status: "unfollowed"}
end

def following
	@user = User.find_by(id: params[:id])
	@following = @user.following
	render json: {
		list: @following
	}
end

def followers
	@user = User.find_by(id: params[:id])
	@followers = @user.followers
	render json: {
		list: @followers
	}
end

#lazy af change later at some point idc
def current_user_following
	@user = current_user
	@following = @user.following
	render json: {
		list: @following
	}
end

def current_user_followers
	@user = current_user
	@followers = @user.followers
	render json: {
		list: @followers
	}
end

end