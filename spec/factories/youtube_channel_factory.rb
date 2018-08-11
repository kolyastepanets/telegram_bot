FactoryBot.define do
  factory :youtube_channel do
    name { %w[Veritasium, Science Channel, Vsauce, brusspup, minutephysics].sample }
    language 'en'
  end
end
