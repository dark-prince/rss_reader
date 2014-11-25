FactoryGirl.define do
  factory :feed do
    title Faker::Name.title
    url Faker::Internet.url
    feed_url Faker::Internet.url
    description Faker::Lorem.word
  end
end