class LikesController < ApplicationController

def like
  @user = current_user
  @post = Post.find(post_params[:post_id])
  @user.like!(@post)
end

def unlike
  @user = current_user
  @like = @user.likes.find_by_post_id(post_params[:post_id])
  @post = Post.find(post_params[:post_id])
  @like.destroy!
end

private 

def post_params
  params.permit(:post_id)
end

end