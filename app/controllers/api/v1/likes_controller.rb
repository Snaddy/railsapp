class Api::V1::LikesController < ApplicationController

def like
  @user = current_user
  @post = Post.find_by(id: params[:id])
  @user.like!(@post)
	render json: {
            success: true,
            info: "liked",
    }
end

def unlike
  @user = current_user
  @like = @user.likes.find_by_post_id(params[:post_id])
  @post = Post.find(params[:post_id])
  @like.destroy!
  	render json: {
            success: true,
            info: "unliked"
    }
end

end