FactoryBot.define do
  factory :item do
    name { Faker::Games::Zelda.item }
    description { Faker::Movies::HitchhikersGuideToTheGalaxy.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant_id { Faker::Number.between(1, 10) }
  end
end
