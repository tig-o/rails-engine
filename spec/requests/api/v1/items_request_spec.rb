require 'rails_helper'

RSpec.describe 'Items API' do
  it 'sends a list of items' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant_id: merchant.id)

    get '/api/v1/items'

    expect(response).to be_successful

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

      expect(item[:attributes]).to_not have_key(:created_at)
      expect(item[:attributes]).to_not have_key(:updated_at)
      
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'can get one item by id' do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    
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

  it 'returns 404 if item not found' do
    get "/api/v1/items/99999"
    expect(response.message).to eq("Not Found")
    expect(response.status).to eq(404)
  end

  it 'can create a new item' do
    merchant = create(:merchant)
    item_params = ({
      name: 'o light',
      description: 'Travel flashlight on the go',
      unit_price: 67.99,
      merchant_id: merchant.id
      })

    post "/api/v1/items", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq("o light")
    expect(created_item.description).to eq("Travel flashlight on the go")
    expect(created_item.unit_price).to eq(67.99)
    expect(created_item.merchant_id).to eq(merchant.id)
  end
end