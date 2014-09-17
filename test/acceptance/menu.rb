require_relative '../test_helper'

describe "menu" do
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
  end

  it "visits menu page" do
    visit '/menu'
    assert page.has_content?("Menu")
  end
end
