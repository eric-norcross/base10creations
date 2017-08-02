# models/admins/admin.rb

FactoryGirl.define do
  factory :admin, class: Admin do
    email                 "test@base10creations.com"
    password              "!SomeAdM1nPa$$w0rd"
    password_confirmation {|u| u.password}
    first_name            "Test"
    last_name             "Admin"
  end
end