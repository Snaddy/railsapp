class Api::V1::PostsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @user = current_user
    @posts = current_user.feed.paginate(page: params[:page], per_page: 15).order('created_at DESC')
    render 'posts/index'
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

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.user_id = current_user.id
        if @post.destroy
          render json: {
            status: "destroyed"
          }
        end
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.user_id = current_user.id
      if @post.update(update_params)
        render json: {
          status: "success",
          caption: @post.caption
        }
      end
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    render 'posts/show'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:speed, :caption, {images: []})
    end

    def update_params
      params.permit(:caption)
    end
end