require 'faker'

FactoryGirl.define do
  factory :category do |f|
    # f.title { Faker::Name.title }
    f.title "Bedroom"
  end
end