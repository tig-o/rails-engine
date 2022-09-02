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
end