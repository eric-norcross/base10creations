require 'rails_helper'

RSpec.describe "pages/show", type: :view do
  before(:each) do
    @page = assign(:page, build(:page))
  end

  it "renders attributes in <p>" do
    render
  end
end
