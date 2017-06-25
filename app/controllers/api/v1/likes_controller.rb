class Api::V1::LikesController < ApplicationController

def like
  @user = current_user
  @post = Post.find_by(post_id: params[:post_id])
  @user.like!(@post)
	render json: {
            success: true,
            info: "liked",
    }
end

def unlike
  @user = current_user
  @like = @user.likes.find_by(post_id: params[:post_id])
  @post = Post.find_by(post_id: params[:post_id])
  @like.destroy!
  	render json: {
            success: true,
            info: "unliked"
    }
end

end