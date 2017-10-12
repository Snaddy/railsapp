class Api::V1::CommentsController < ApplicationController

	before_action :find_post

	def create
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			render json: {
				status: 'success',
				id: @comment.id,
				user_id: @comment.user_id,
				post_id: @comment.post_id,
				content: @comment.content,
				username: @comment.user.username,
				avatar: @comment.user.avatar
			}
		else
			render json: {status: @comment.errors.full_messages}
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
		if current_user.id = @comment.user_id || @post.user_id
			@comment.destroy
			render json: {status: 'destroyed'}
		end
	end

	private

   	def comment_params
        params.permit(:content)
   	end

   	def find_post
   		@post = Post.find(params[:post_id])
   	end

end