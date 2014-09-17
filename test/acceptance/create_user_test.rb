require_relative '../test_helper'

describe "login" do
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
  end

  it 'creates new user' do
    visit '/create-user'
    fill_in('user_name', with: 'Cara')
    fill_in('password1', with: '1234')
    fill_in('password2', with: '1234')
    click_on('Submit')
    assert page.has_content?('Admin Menu')
    assert page.has_content?('Cara')
  end

end
