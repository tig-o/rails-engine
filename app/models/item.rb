class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_items(query)
    where("name ILIKE ?", "%#{query}%")
  end
end
