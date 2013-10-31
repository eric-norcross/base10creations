require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  fixtures :categories

  before do
    @category = Category.new
  end

  test "Attribute columns exists" do
    # Control
    assert !ActiveRecord::Base.connection.column_exists?('categories', 'blah'), "'blah' column exists on categories table "

    # Exists
    assert ActiveRecord::Base.connection.column_exists?('categories', 'name'), "'name' column does not exists on categories table"
    assert ActiveRecord::Base.connection.column_exists?('categories', 'title'), "'title' column does not exists on categories table"
    assert ActiveRecord::Base.connection.column_exists?('categories', 'link'), "'link' column does not exists on categories table"
    
  end

  test "Should not save a category without title" do
    assert !@category.save, "Saved the category without a title"
  end

  test "Should create a parameterized name from title" do
    assert !@category.name, "Name exists without being assigned"
    @category.title = "Bedroom Sets"
    @category.save
    assert_equal @category.name, "bedroom-sets"
  end

  test "Link should accept..." do
    # Control
    category_with_title = categories(:title_only)
    assert category_with_title.valid?, "Category is not valid"

    # Invalid
    category_with_title.link = "www.whatever.com"
    assert !category_with_title.valid?, "Category is valid with unsupported link attribute pattern"
    
    # Valid
    category_with_title.link = ""
    assert category_with_title.valid?, "Category is not valid with blank link attribute"
    
    category_with_title.link = "https://whatever.com"
    assert category_with_title.valid?, "Category is not valid with 'https://' prefix"
    
    category_with_title.link = "http://whatever.com"
    assert category_with_title.valid?, "Category is not valid with 'http://' prefix"
    
    category_with_title.link = "/location"
    assert category_with_title.valid?, "Category is not valid with '/' prefix"
  end
end