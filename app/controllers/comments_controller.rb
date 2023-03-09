class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @good_found = GoodFound.find(params[:good_found_id])
    @comment = @good_found.comments.new(comment_params)
    if @comment.save
      CommentChannel.broadcast_to @good_found, { comment: @comment, user: @comment.user }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, good_found_id: params[:good_found_id])
  end
end
