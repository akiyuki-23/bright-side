class GoodFoundsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_index, only: [:edit, :update]
  def index
    @good_founds = GoodFound.order('created_at DESC')
  end

  def new
    @good_found = GoodFound.new
  end

  def create
    @good_found = GoodFound.new(good_found_params)
    if @good_found.save
      redirect_to root_path, notice: 'You had a good day!! いい日ですね！'
    else
      render :new
    end
  end

  def show
    @good_found = GoodFound.find(params[:id])
  end

  def edit
  end

  def update
    if @good_found.update(good_found_params)
    redirect_to good_found_path(@good_found.id)
    else
      render :edit
    end
  end

  private

  def good_found_params
    params.require(:good_found).permit(:execution_date, :title, :event_detail, :category_id).merge(user_id: current_user.id)
  end

  def move_to_index
    @good_found = GoodFound.find(params[:id])
    return if @good_found.user == current_user

    redirect_to root_path
  end
end
