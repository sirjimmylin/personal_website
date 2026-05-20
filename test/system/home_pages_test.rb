require "application_system_test_case"

class HomePagesTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_url
  
    assert_selector "h1" # We just check if there's any h1
  end
end
