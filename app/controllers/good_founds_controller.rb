class GoodFoundsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @good_founds = GoodFound.order('created_at DESC')
  end

  def new
    @good_found = GoodFound.new
  end

  def create
    @good_found = GoodFound.new(good_found_params)
    if @good_found.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def good_found_params
    params.require(:good_found).permit(:execution_date, :title, :event_detail, :category_id).merge(user_id: current_user.id)
  end
end
