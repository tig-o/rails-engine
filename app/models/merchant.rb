class Merchant < ApplicationRecord
  has_many :items

  def self.find_merchant(query)
    where("name ILIKE ?", "%#{query}%").order("name").first
  end
end
