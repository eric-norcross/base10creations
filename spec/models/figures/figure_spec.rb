# models/figures/figure.rb

require "rails_helper"
require "models/figures/figure_factory"

describe Figure do
  it "has a valid factory" do
    expect(build(:figure)).to be_valid
  end
end