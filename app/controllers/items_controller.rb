class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(items_params)
    render json: item, status: :created
  end

  private

  def render_not_found
    render json: { error: 'review not found' }, status: :not_found
  end

  def items_params
    params.permit(:name, :description, :price)
  end
end
