require 'spec_helper'

describe BrandStyle do
  context "- METHOD - method_name " do
    it "should create a brand style" do
      brand = Factory.create(:brand)
      10.times { |i| Factory.create(:feature, :widget => widget)}
      result = WidgetFeature.method_name(brand.id)
      # do all the checks and expectations now
    end
  end
end

