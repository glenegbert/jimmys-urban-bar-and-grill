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
    db[:menu_section][:name]       = params[menu[section_name]]
    db[:menu_section][:details]    = params[menu[section_description]]
    db[:menu_items][:name]         = params[menu[item_name]]
    db[:menu_items][:price]        = params[menu[price]]
    db[:menu_items][:description]  = params[menu[item_description]]
    db[:menu_items][:menu_section] = params[menu[menu_section]]
    db[:menu_items][:menu_section] = params[menu[item_menu_section]]
    redirect '/admin-menu'
  end

  not_found do
    erb :error
  end

end
