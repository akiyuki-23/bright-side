class CommentChannel < ApplicationCable::Channel
  def subscribed
    @good_found = GoodFound.find(params[:good_found_id])
    stream_for @good_found
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
