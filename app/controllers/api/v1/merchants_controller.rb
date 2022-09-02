class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.format_merchants(Merchant.all)
  end

  def show
    if Merchant.exists?(params[:id])
      render json: MerchantSerializer.format_merchant(Merchant.find(params[:id]))
    else
      render json: {error: "Not Found"}, status: 404      
    end
  end
end