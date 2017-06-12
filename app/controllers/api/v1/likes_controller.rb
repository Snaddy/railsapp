class Api::V1::LikesController < ApplicationController

def create
  @user = current_user
  @post = Post.find(params[:id])
  @user.like!(@post)
	render json: {
            success: true,
            info: "liked",
    }
end

def destroy
  @user = current_user
  @like = @user.likes.find_by_post_id(params[:id])
  @post = Post.find(params[:id])
  @like.destroy!
  	render json: {
            success: true,
            info: "failed"
    }
end

end