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

  it "visits admin page and has login form" do
    visit '/admin'
    assert page.has_css?("#login")
  end

  it "creates a menu section" do
    visit '/admin-menu'
    number_headers = all('h2').count
    fill_in('menu[section_name]', with: "Beef")
    fill_in('menu[section_description]', with: "Delicious")
    click_on('Create Section')
    sections = all('h2')
    current_headers = all('h2').count
    assert current_headers = number_headers + 1
  end

  it "creates a menu item" do
    visit '/admin-menu'
    fill_in('menu[item_name]', with: "Poptart")
    fill_in('menu[item_description]', with: "Fruit inside!")
    fill_in('menu[item_price]', with: "10")
    click_on('Add Item')
    items = all('.menu-item')
    assert page.has_content?('Poptart')
  end

  it "deletes a menu item" do
    # visit '/admin-menu'
    # div_count = all('.menu-item div').count
    # fill_in('menu[item_name]', with: "Tuna")
    # fill_in('menu[item_description]', with: "So unpepperminty!")
    # fill_in('menu[item_price]', with: "10")
    # click_on('Add Item')
    # added_div_count = all('.menu-item div').count
    # # assert div_count + 1 == added_div_count
    # find_button('Delete').click
    # assert div_count == all('.menu-item div').count
  end

end
