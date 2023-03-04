class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @comment = Comment.create(comment_params)
    @good_found = @comment.good_found
    @comments = @good_found.comments
  end

  def destroy
    @good_found = GoodFound.find(params[:good_found_id])
    comment = @good_found.comments.find(params[:id])
    comment.destroy
    redirect_to good_found_path(comment.good_found)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, good_found_id: params[:good_found_id])
  end
end
