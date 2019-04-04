require 'test_helper'

class PartecipantsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get partecipants_create_url
    assert_response :success
  end

  test "should get destroy" do
    get partecipants_destroy_url
    assert_response :success
  end

end
