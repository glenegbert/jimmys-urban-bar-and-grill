require 'sinatra'
# require 'sinatra-flash'

class Jimmys < Sinatra::Application
  # register Sinatra::Flash
  enable :sessions
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

  get '/admin' do
    #if !session
      erb :login
    #else
      # redirect '/admin-menu'
    #end
  end

  post '/login' do

  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/admin-menu' do
    erb :admin_menu
  end

  post '/admin-menu' do
    # name         = params[:name]
    # description  = params[:description]
    # price        = params[:price]
    # menu_section = params[:menu_section]
    redirect '/admin-menu'
  end

end
