require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "Jscript")
  end

  test "Category should be valid" do
    assert @category.valid?
    
  end
  
  test "Name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end
  
  test "Name Should be Unique" do
    @category.save
    category2 = Category.new(name: "Jscript")
    assert_not category2.valid?
  end
  
  test "No long name" do
    @category.name = "a" * 100
    assert_not @category.valid?
  end
  
  test "No short name" do
    @category.name = "aa"
    assert_not @category.valid?
  end
  
end
