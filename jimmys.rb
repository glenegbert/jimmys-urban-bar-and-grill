require 'sinatra'

class Jimmys < Sinatra::Application
  enable :sessions

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

  get '/login' do
    erb :login
  end

  post '/login' do
    
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
