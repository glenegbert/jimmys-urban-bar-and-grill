require 'sinatra'

class Jimmys < Sinatra::Application
  attr_reader :db

  class << self
    attr_accessor :db
  end

  before do
    @db = self.class.db
  end

  get '/' do
    erb :index
  end

  get '/about-us' do
    erb :about_us
  end

  get '/contact-us' do
    erb :contact_us
  end

  get '/location' do
    erb :location
  end

  get '/menu' do
    erb :menu
  end

  post '/menu' do
    name         = params[:name]
    description  = params[:description]
    price        = params[:price]
    menu_section = params[:menu_section]
    redirect '/menu'
  end

end
