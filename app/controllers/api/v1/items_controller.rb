class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.format_items(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.format_item(Item.find(params[:id]))
    else
      render json: {error: "Not Found"}, status: 404      
    end
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.format_item(item), status: 201
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end