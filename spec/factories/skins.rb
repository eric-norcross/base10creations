# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skin, :class => 'Skins' do
    name "MyString"
    title "MyString"
    template "MyString"
  end
end
