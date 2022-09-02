require 'rails_helper'

RSpec.describe 'Finder' do
  it 'can find a merchant based on partial query' do
    toyota = create(:merchant, name: "Toyota")
    honda = create(:merchant, name: "Honda")

    get "/api/v1/merchants/find?name=oYo"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response).to be_successful

    expect(merchant).to have_key(:id)
    expect(merchant[:attributes][:name]).to eq("Toyota")
  end

  it 'can return a no merchant found error' do
    toyota = create(:merchant, name: "Toyota")
    honda = create(:merchant, name: "Honda")

    get "/api/v1/merchants/find?name=ZzZzZ"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response).to be_successful

    expect(merchant[:error]).to eq("No Merchant Found")
    expect(response.status).to eq(200)
  end

  it 'can return a 400 error if no merchant params are passed' do
    get "/api/v1/merchants/find"
    expect(response.status).to eq(400)
  end

  it 'can find all items based on a partial query' do
    rei = create(:merchant, name: "R.E.I")

    s_tent = create(:item, name: "2 ppl tent", merchant_id: rei.id)
    bear_spray = create(:item, name: "Bear Spray", merchant_id: rei.id)
    l_tent = create(:item, name: "6 ppl tent", merchant_id: rei.id)

    get "/api/v1/items/find_all?name=tEnT"
    
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(items.first[:attributes][:name]).to eq('2 ppl tent')
    expect(items.last[:attributes][:name]).to eq('6 ppl tent')
  end

  it 'can return empty data' do
    rei = create(:merchant, name: "R.E.I")

    s_tent = create(:item, name: "2 ppl tent", merchant_id: rei.id)
    bear_spray = create(:item, name: "Bear Spray", merchant_id: rei.id)
    l_tent = create(:item, name: "6 ppl tent", merchant_id: rei.id)

    get "/api/v1/items/find_all?name=zZzZz"
    
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items).to be_empty
    expect(items).to be_an Array
  end

  it 'can return a 400 error if no item params are passed' do
    get "/api/v1/items/find_all"
    expect(response.status).to eq(400)
  end
end