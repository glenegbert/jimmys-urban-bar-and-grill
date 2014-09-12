require 'sinatra'

class Jimmys < Sinatra::Application

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

end
