class Api::V1::FindController < ApplicationController
  def find_one_merchant
    if params[:name].nil?
      render json: {error: "Not Found"}, status: 400
    else
      merchant = Merchant.find_merchant(params[:name])
      if merchant.nil?
        render json: {data: { error: 'No Merchant Found'}}, status: 200
      else
        render json: MerchantSerializer.format_merchant(merchant)
      end
    end
  end

  def find_all_items
    if params[:name].nil?
      render json: {error: "Not Found"}, status: 400
    else
      items = Item.find_items(params[:name])
      if items.nil?
        render json: {data: { data: [] }}, status: 200
      else
        render json: ItemSerializer.format_items(items)
      end
    end   
  end
end