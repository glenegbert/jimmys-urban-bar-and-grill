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

  get '/location' do
    erb :location
  end

  get '/menu' do
    erb :menu
  end

  get '/admin' do
      erb :login
  end

  post '/login' do

  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/admin-menu' do
    erb :admin_menu, locals: {:menu_items => db[:menu_items].to_a, :menu_sections => db[:menu_sections].to_a}
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

  get '/admin/hours' do
    erb :admin_hours, locals: {:hours => db[:location_hours].to_a}
  end

  post '/admin/hours' do

      day_of_week       = params[:hours][:day_of_week]
      opening_hour      = params[:hours][:opening_hour]
      opening_minute    = params[:hours][:opening_minute]
      opening_period    = params[:hours][:opening_period]
      closing_hour      = params[:hours][:closing_hour]
      closing_minutes   = params[:hours][:closing_minute]
      closing_period    = params[:hours][:closing_period]

      db[:location_hours].insert(
                                  day_of_week:    day_of_week,
                                  opening_hour:   opening_hour,
                                  opening_minute: opening_minute,
                                  opening_period: opening_period,
                                  closing_hour:   closing_hour,
                                  closing_minute: closing_minute,
                                  closing_period: closing_period
                                  )

      redirect '/admin/hours'
  end

  delete '/admin/hours/:id' do |id|
    db[:location_hours].where(id: id.to_i).delete
    redirect '/admin/hours'
  end

  get '/admin/hours/:id/edit' do |id|
    section = db[:location_hours].where(id: id.to_i).to_a.first
    erb :edit_location_hours, locals: { location_hours: hours }
  end

  patch '/admin/hours/:id/edit' do |id|
    day_of_week       = params[:hours][:day_of_week]
    opening_hour      = params[:hours][:opening_hour]
    opening_minute    = params[:hours][:opening_minute]
    opening_period    = params[:hours][:opening_period]
    closing_hour      = params[:hours][:closing_hour]
    closing_minutes   = params[:hours][:closing_minute]
    closing_period    = params[:hours][:closing_period]

    db[:location_hours] .where(id: id.to_i)
                        .update(
                                day_of_week:    day_of_week,
                                opening_hour:   opening_hour,
                                opening_minute: opening_minute,
                                opening_period: opening_period,
                                closing_hour:   closing_hour,
                                closing_minute: closing_minute,
                                closing_period: closing_period
                                )
    redirect '/admin/hours'
  end

  not_found do
    erb :error
  end



   # private method
    # def items_in_section(menu_items, section_id)
        # menu_items.to_a
        # menu_items.collect{ |item| item[:menu_section_id] == section_id}
        #column_name
        # menu_section_id
    # end

end
