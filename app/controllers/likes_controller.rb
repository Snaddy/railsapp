class LikesController < ApplicationController

def like
  @user = current_user
  @post = Post.find(post_params)
  @user.like!(@post)
end

def unlike
  @user = current_user
  @like = @user.likes.find_by_post_id(post_params)
  @post = Post.find(post_params)
  @like.destroy!
end

private 

def post_params
  params.permit(:post_id)
end

end