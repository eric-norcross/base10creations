require 'spec_helper'

describe Category do
	it "has a valid factory" do
		FactoryGirl.create(:category).should be_valid
	end

	it "is invalid without a title" do
		FactoryGirl.build(:category, title: nil).should_not be_valid
	end

	it "creates a parameterized name from title" do
		record = FactoryGirl.build(:category, title: "Bedroom Sets")
		record.save
		record.name.should == "bedroom-sets"
	end

	it "has a link parameter" do
		FactoryGirl.build(:category, link: nil).should be_valid
	end

	it 'accepts blank for link' do
		FactoryGirl.build(:category, link: "").should be_valid
	end

	it 'only accepts "http://", "https://", and "/" prefixed to links when filled in' do
		# valid
    FactoryGirl.build(:category, link: "http://").should be_valid
    FactoryGirl.build(:category, link: "https://").should be_valid
    FactoryGirl.build(:category, link: "/").should be_valid
    
    # invalid
    FactoryGirl.build(:category, link: "locations/10").should_not be_valid
    FactoryGirl.build(:category, link: "lskdfjldskf").should_not be_valid
	end
end
