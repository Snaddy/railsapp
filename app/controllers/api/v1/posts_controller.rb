class Api::V1::PostsController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @posts = current_user.feed.order('created_at DESC')
    @post = Post.find(params[:id])
    @likes = current_user.like?(@post)
    respond_to do |format|
      format.json {
        render json: {
          :posts => @posts,
          #@posts.to_json(methods: :get_likes_count, include: { user: { only: :username, methods: :like?} }),
          :likes => @likes
        }
      }
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render json: {
            success: true,
            info: "success"
      }
    else
       render json: {
            success: false,
            info: "failed"
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:speed, :caption, {images: []})
    end
end