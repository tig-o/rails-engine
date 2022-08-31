FactoryBot.define do
  factory :merchant do
    name { Faker::JapaneseMedia::DragonBall.character }
  end
end
