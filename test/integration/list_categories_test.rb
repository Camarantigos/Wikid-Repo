require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Jscript")
    @category2 = Category.create(name: "Ruby")
  end
  
  test "should redirect create when no admin in" do
    assert_no_difference 'Category.count' do
      post :create, category: { name: "Jscript" }
    end
    assert_redirected_to categories_path
  end
  
  test "should show categories listing" do
    get categories_path
    assert_template 'categories/index'
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
    
  end
  
  
end