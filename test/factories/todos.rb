FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.characters(number: 40) }
    status { 0 }
    user { nil }
  end
end
