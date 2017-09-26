require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "Jscript")
    @user = User.create(username: "Chamour", email: "chamour@datalink.com.gr", password: "password", admin: true)
  end
  
  test "Should get categories Index" do
    get :index
    assert_response :success
  end
  
  test "Should get New" do
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end
  
  test "should get show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  
end