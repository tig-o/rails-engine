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
end