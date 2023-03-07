class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @good_found = GoodFound.find(params[:good_found_id])
    @comment = @good_found.comments.new(comment_params)
    if @comment.save
      CommentChannel.broadcast_to @good_found, { comment: @comment, user: @comment.user }
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to good_found_path(@comment.good_found)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, good_found_id: params[:good_found_id])
  end
end
