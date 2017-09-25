require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "Jscript")
  end
  
  test "Should get categories Index" do
    get :index
    assert_response :success
    
  end
  
  test "Should get New" do
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  
end