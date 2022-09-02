require 'rails_helper'

RSpec.describe 'Merchant Items Request API' do
  it 'sends all items that belong to a merchant' do
    id = create(:merchant).id
    create_list(:item, 5, merchant_id: id)

    get "/api/v1/merchants/#{id}/items/"

    response_data = JSON.parse(response.body, symbolize_names: true)
    items = response_data[:data]
    
    expect(items.count).to eq(5)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item).to have_key(:type)
      expect(item).to have_key(:attributes)
      
      expect(item[:id]).to be_a(String)
      expect(item[:type]).to be_a(String)
      expect(item[:attributes]).to be_a(Hash)
      
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes]).to have_key(:merchant_id)

      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'returns 404 if merchant items not found' do
    get "/api/v1/merchants/42/items"
    expect(response.message).to eq("Not Found")
    expect(response.status).to eq(404)
  end

  it 'can get an items merchant' do
    created_merchant = create(:merchant)
    item_id = create(:item, merchant_id: created_merchant.id).id

    get "/api/v1/items/#{item_id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:id]).to eq(created_merchant.id.to_s)
    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_an(String)

    expect(merchant[:data][:type]).to eq("merchant")

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end