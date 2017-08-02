# models/pages/page.rb

require "rails_helper"
require "models/pages/page_factory"

describe Page do
  it "has a valid factory" do
    expect(build(:page)).to be_valid
  end
end