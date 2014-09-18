require 'sinatra'
require 'pony'
require 'bcrypt'
require_relative './lib/user'
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

  get '/about-us/edit' do
    erb :about_edit
  end

  post '/about-us/edit' do

  end

  patch '/about-us/edit' do

  end

  delete '/about-us/edit' do

  end

  get '/contact-us' do
    erb :contact_us
  end

  post '/contact-us' do
    Pony.subject_prefix("REGARDING JIMMY'S URBAN: ")
    Pony.mail ({
      :subject => params[:subject],
      :from    => params[:mail],
      :body    => params[:message],
      :to      => 'jimmysurbanbarandgrill@yahoo.com',
      :via     => :sendmail
    })
    redirect '/'
  end

  get '/location' do
    erb :location
  end

  get '/menu' do
    @sections = db[:menu_sections]
    @items    = db[:menu_items]
    erb :menu
  end

  get '/create-user' do
    erb :create_user, locals: { message: params[:success] }
  end

  post '/create-user' do
    if params[:password1] == params[:password2]
      # password_salt = BCrypt::Engine.generate_salt
      # password_hash = BCrypt::Engine.hash_secret(params[:password1], password_salt)
      password_hash = BCrypt::Password.create(params[:password1])
      user = User.new(db, params[:user_name], password_hash)
      if success = user.create?
        user = db[:users].where(name: params[:user_name]).to_a.first
        session[:user_id] = user[:id]
        redirect '/admin-menu?success=true'
      end
    end
    redirect "/create-user?success=false"
  end

  get '/admin-menu' do
    sections = db[:menu_sections].to_a
    items    = db[:menu_items].to_a
    erb :admin_menu, locals: { menu_sections: sections,
                               menu_items:    items    }
  end

  post '/admin-menu' do
    section_name        = params[:menu][:section_name]
    section_description = params[:menu][:section_description]

    name        = params[:menu][:item_name]
    description = params[:menu][:item_description]
    price       = params[:menu][:item_price]
    section     = params[:menu][:item_menu_section]

    if !section_name.nil? && !section_description.nil?
      db[:menu_sections].insert(:name => section_name, :details => section_description)
    end

    if !name.nil? && !description.nil? && !price.nil? && !section.nil?
      db[:menu_items].insert(:name => name, :description => description, :price => price, :menu_section_id => section)
    end

    redirect '/admin-menu'
  end

  not_found do
    erb :error
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    user = db[:users].where(name: params[:user_name]).to_a.first
    unless user.nil? || user[:password_hash].nil?
      my_password = BCrypt::Password.new(user[:password_hash])
      if user && my_password == params[:user_password]
        id = user[:id]
        session[:user_id] = id
        redirect "/admin-menu?success=true"
      end
    end
    redirect '/login?success=false'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  delete '/admin-menu/sections/:id' do |id|
    db[:menu_sections].where(id: id.to_i).delete
    redirect '/admin-menu'
  end

  get '/admin-menu/sections/:id/edit' do |id|
    section = db[:menu_sections].where(id: id.to_i).to_a.first
    erb :edit_menu_section, locals: { menu_section: section }
  end

  patch '/admin-menu/sections/:id/edit' do |id|
    name    = params[:menu][:section_name]
    details = params[:menu][:section_description]
    db[:menu_sections].where(id: id.to_i).update(name: name, details: details)
    redirect '/admin-menu'
  end


  get '/admin-menu/items/:id/edit' do |id|
    section = db[:menu_items].where(id: id.to_i).first
    erb :edit_menu_item, locals: { menu_item: section }
  end

  patch '/admin-menu/items/:id/edit' do |id|
    name    = params[:menu][:item_name]
    details = params[:menu][:item_description]
    price   = params[:menu][:item_price]
    db[:menu_items].where(id: id.to_i).update(name: name, description: details, price: price)
    redirect '/admin-menu'
  end

  delete '/admin-menu/items/:id' do |id|
    db[:menu_items].where(id: id.to_i).delete
    redirect '/admin-menu'
  end

end
