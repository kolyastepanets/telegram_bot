FactoryBot.define do
  factory :user do
    uid { rand(100000...999999999) }
    language 'en'
  end
end
