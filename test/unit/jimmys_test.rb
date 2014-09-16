require_relative './test_helper'
require_relative '../jimmys'

describe Jimmys do
  include Rack::Test::Methods

  def app
    Jimmys.new
  end

  describe 'correctly loads page routes' do
    it 'correctly loads home page' do
      get '/'
      assert_equal 200, last_response.status
    end

    it 'correctly loads about us page' do
      get '/aboutus'
      assert_equal 200, last_response.status
    end

    it 'correctly loads contact us page' do
      get '/contactus'
      assert_equal 200, last_response.status
    end

    it 'correctly loads location page' do
      get '/location'
      assert_equal 200, last_response.status
    end

    it 'correctly loads menu page' do
      get '/menu'
      assert_equal 200, last_response.status
    end
  end
end
