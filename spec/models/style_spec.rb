require 'spec_helper'

describe Style do
  it "has a valid factory" do
    FactoryGirl.create(:style).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:style, title: nil).should_not be_valid
  end

  it "creates a parameterized name from title" do
    record = FactoryGirl.build(:style, title: "Metropolitan Modern")
    record.save
    record.name.should == "metropolitan-modern"
  end

  it "has a link parameter" do
    FactoryGirl.build(:style, link: nil).should be_valid
  end

  it 'accepts blank for link' do
    FactoryGirl.build(:style, link: "").should be_valid
  end

  it 'only accepts "http://", "https://", and "/" prefixed to links' do
    # valid
    FactoryGirl.build(:style, link: "http://").should be_valid
    FactoryGirl.build(:style, link: "https://").should be_valid
    FactoryGirl.build(:style, link: "/").should be_valid
    
    # invalid
    FactoryGirl.build(:style, link: "locations/10").should_not be_valid
    FactoryGirl.build(:style, link: "lskdfjldskf").should_not be_valid
  end
end
