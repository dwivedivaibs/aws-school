require 'test_helper'

class TcEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tc_entries_index_url
    assert_response :success
  end

end
