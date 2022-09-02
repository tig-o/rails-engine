require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end
  
  describe 'model methods' do
    it 'can find a merchant with keyword' do
      toyota = create(:merchant, name: "Toyota")
      honda = create(:merchant, name: "Honda")

      expect(Merchant.find_merchant("oYo")).to eq(toyota)
    end
  end
end
