require 'spec_helper'

describe Brand do
  it "has a valid fabrication" do
    Fabricate(:brand).should be_valid
  end
end
