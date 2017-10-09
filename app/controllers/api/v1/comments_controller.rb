class Api::V1::CommentsController < ApplicationController

	def create
		@post = Post.find_by(id: params[:id])
		@comment = @post.comments.build(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			render json: {status: 'success'}
		else
			render json: {status: post.errors.full_messages}
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
		if current_user.id = @comment.user_id
			@comment.destroy
			render json: {status: 'destroyed'}
		end
	end

	private

   	def comment_params
        params.permit(:content)
   	end

end