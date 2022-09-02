class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id]) #First we need to identify a merchant
    render json: ItemSerializer.format_items(merchant.items) #At the model level, a Merchant has_many Items
  end
end