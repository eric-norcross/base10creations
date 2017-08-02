# models/pages/page.rb

FactoryGirl.define do
  factory :page, class: Page do
    name "Test Page"
    slug "test-page"
  end
end