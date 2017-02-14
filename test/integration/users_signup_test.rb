require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup submission" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "foo",
                                         password_confirmation: "foobar"
                                                                        }  }
    end
    assert_template "users/new"
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger'
  end

  test "valid signup submission" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params: { user: { name: "Example User",
                                           email: "exampleuser@railstutorial.org",
                                           password: "foobar",
                                           password_confirmation: "foobar"
                                                                        }   }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_equal flash[:success], "Welcome to the Sample App Example User!"
  end

end
