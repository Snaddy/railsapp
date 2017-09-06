class Api::V1::RelationshipsController < ApplicationController

	before_action :authenticate_user!

def create
	@user = User.find_by(id: params[:id])
	current_user.follow!(@user)
	render json: {status: "followed"}
end

def destroy
	@user = Relationship.find_by(follow_id: params[:user_id])
	current_user.unfollow!(@user)
	render json: {status: "unfollowed"}
end

end