require_relative '../test_helper'

describe "menu" do
  include Capybara::DSL

  it "visits menu page" do
    visit '/menu'
    assert page.has_content?("Menu")
  end
end
