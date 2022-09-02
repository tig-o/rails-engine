require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'model methods' do
    it 'can find all items with keyword' do
      rei = create(:merchant, name: "R.E.I")

      tent = create(:item, name: "Tent", merchant_id: rei.id)
      mosquito_spray = create(:item, name: "Mosquito Spray", merchant_id: rei.id)
      bear_spray = create(:item, name: "Bear Spray", merchant_id: rei.id)

      expect(Item.find_items("sPrAy")).to eq([mosquito_spray, bear_spray])
    end
  end
end
