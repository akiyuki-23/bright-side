class CommentsController < ApplicationController
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

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, good_found_id: params[:good_found_id])
  end
end
