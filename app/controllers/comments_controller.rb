class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to good_found_path(@comment.good_found)
    else
      @good_found = @comment.good_found
      @comments = @good_found.comments
      render template: "good_founds/show"
    end
  end

  def destroy
    @comment = Comment.find_by(params[:id], good_found_id: params[:good_found_id])
    @comment.destroy
    redirect_to good_found_path(@comment.good_found)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, good_found_id: params[:good_found_id])
  end
end
