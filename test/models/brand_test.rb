require "test_helper"

class BrandTest < ActiveSupport::TestCase
  fixtures :brands
  fixtures :styles

  before do
    @brand = Brand.new
  end

  test "Attribute columns exists" do
    # Control
    assert !ActiveRecord::Base.connection.column_exists?('brand', 'blah'), "'blah' column exists on brand table "

    # Exists
    assert ActiveRecord::Base.connection.column_exists?('brand', 'name'), "'name' column does not exists on brand table"
    assert ActiveRecord::Base.connection.column_exists?('brand', 'title'), "'title' column does not exists on brand table"
    assert ActiveRecord::Base.connection.column_exists?('brand', 'description'), "'description' column does not exists on brand table"
    assert ActiveRecord::Base.connection.column_exists?('brand', 'link'), "'link' column does not exists on brand table"
  end

  test "Should not save a brand without title" do
    assert !@brand.save, "Saved the brand without a title"
  end

  test "Should create a parameterized name from title" do
    assert !@brand.name, "Name exists without being assigned"
    @brand.title = "Bedroom Sets"
    @brand.save
    assert_equal @brand.name, "bedroom-sets"
  end

  test "'link' attribute should accept..." do
    # Control
    brand = brands(:martin_home_furnishings)
    assert brand.valid?, "Brand is not valid"

    # Invalid
    brand.link = "www.whatever.com"
    assert !brand.valid?, "Brand is valid with unsupported link attribute pattern"
    
    # Valid
    brand.link = ""
    assert brand.valid?, "Brand is not valid with blank link attribute"
    
    brand.link = "https://whatever.com"
    assert brand.valid?, "Brand is not valid with 'https://' prefix"
    
    brand.link = "http://whatever.com"
    assert brand.valid?, "Brand is not valid with 'http://' prefix"
    
    brand.link = "/location"
    assert brand.valid?, "Brand is not valid with '/' prefix"
  end

  # test "should accept styles"
  #   # c = Company.create!
  #   # u = User.create!
  #   # c.users << u
  #   # c.destroy
  #   # assert_equal [], Participation.all.to_a
  #   # assert_equal [], User.all.to_a
  #   brand = brand(:no_styles)
  #   styles = [style(:modern), style(:contemporary), style(:traditional)]
  #   brand.styles << styles
    
  #   assert brand.valid?, "Brand is valid without any associated styles"
  # end
end