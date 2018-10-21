require 'test_helper'

class AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get author" do
    get about_author_url
    assert_response :success
  end

end
