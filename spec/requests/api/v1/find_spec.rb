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
end