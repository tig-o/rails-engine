class Api::V1::MerchantsController < ApplicationController
  def index
    # render json: Merchant.all
    render json: MerchantSerializer.format_merchants(Merchant.all)
  end

  def show
    render json: Merchant.find(params[:id])
  end
end