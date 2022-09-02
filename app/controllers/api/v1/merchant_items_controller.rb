class Api::V1::MerchantItemsController < ApplicationController
  def index
    if Item.exists?(merchant_id: params[:merchant_id])
      merchant = Merchant.find(params[:merchant_id]) #First we need to identify a merchant
      render json: ItemSerializer.format_items(merchant.items) #At the model level, a Merchant has_many Items
    else
      render json: {error: "Not Found"}, status: 404
    end
  end
end