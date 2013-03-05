require 'spec_helper'

describe "pages/show" do
  before(:each) do
    @page = assign(:page, stub_model(Page,
      :name => "Name",
      :header => "Header"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Header/)
  end
end
