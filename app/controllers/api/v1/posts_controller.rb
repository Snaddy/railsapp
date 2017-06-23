class Api::V1::PostsController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @posts = current_user.feed.order('created_at DESC')
    #@likes = current_user.likes.where(post_id: @posts.map(&:id))
     respond_to do |format|
      format.json do
        render :json => {
          posts: @posts.as_json(methods: [:get_likes_count, :like?], include: { user: { only: :username} }),
      }
      end
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