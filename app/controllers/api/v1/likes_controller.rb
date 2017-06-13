class Api::V1::LikesController < ApplicationController

def like
  @user = current_user
  @post = @user.posts
  @user.like!(@post)
	render json: {
            success: true,
            info: "liked",
    }
end

def unlike
  @user = current_user
  @like = @user.likes.find_by_post_id(params[:post_id])
  @post = @user.posts
  @like.destroy!
  	render json: {
            success: true,
            info: "failed"
    }
end

end