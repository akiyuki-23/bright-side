class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to good_found_path(@comment.good_found) }
        format.json { render json: { comment: @comment, success: true } }
      end
    else
      @good_found = @comment.good_found
      @comments = @good_found.comments
      respond_to do |format|
        format.html { render template: "good_founds/show" }
        format.json { render json: { errors: @comment.errors.full_messages, success: false } }
      end
    end
  end

  def destroy
    @comment = Comment.find_by(params[:id], good_found_id: params[:good_found_id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to good_found_path(@comment.good_found) }
      format.json { render json: { success: true } }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, good_found_id: params[:good_found_id])
  end
end
