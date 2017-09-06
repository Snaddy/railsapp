class Api::V1::RelationshipsController < ApplicationController

	before_action :authenticate_user!

def create
	@user = User.find_by(id: params[:followed_id])
	current_user.follow(@user)
end

def destroy
	@user = Relationship.find_by(id: params[:id]).followed
	current_user.unfollow(@user)
end

end