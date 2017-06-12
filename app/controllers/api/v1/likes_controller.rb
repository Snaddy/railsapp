class Api::V1::LikesController < ApplicationController

def like
  @user = current_user
  @posts = current_user.feed.order('created_at DESC')
  @user.like!(@posts)
	render json: {
            success: true,
            info: "liked",
    }
  
end

def unlike
  @user = current_user
  @like = @user.likes.find_by_post_id(params[:post_id])
  @posts = current_user.feed.order('created_at DESC')
  @like.destroy!
  	render json: {
            success: true,
            info: "disliked"
    }
end

end