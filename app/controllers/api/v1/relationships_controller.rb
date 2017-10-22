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
	@users = @user.following.paginate(page: params[:page], per_page: 15)
	render 'lists/users'
end

def followers
	@user = User.find_by(id: params[:id])
	@users = @user.followers.paginate(page: params[:page], per_page: 15)
	render 'lists/users'
end

#lazy af change later at some point idc
def current_user_following
	@user = current_user
	@users = @user.following.paginate(page: params[:page], per_page: 15)
	render 'lists/users'
end

def current_user_followers
	@user = current_user
	@users = @user.followers.paginate(page: params[:page], per_page: 15)
	render 'lists/users'
end

end