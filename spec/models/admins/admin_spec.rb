# models/admins/admin.rb

require "rails_helper"
require "models/admins/admin_factory"

describe Admin do
  it "has a valid factory" do
    expect(build(:admin)).to be_valid
  end
end