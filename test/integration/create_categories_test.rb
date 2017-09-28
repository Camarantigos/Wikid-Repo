require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "Chamour", email: "chamour@datalink.com.gr", password: "password", admin: true)
  end

  
  test "get new cat form and create it" do
    sign_in_as(@user, "password")
    get new_category_path  
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
    post_via_redirect categories_path, category: {name: "Jscript"}
    end
    assert_template 'categories/index'
    assert_match "Jscript", response.body
  end
  
  test "invalid cat submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
    post categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end