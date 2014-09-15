require './jimmys'
require 'sequel'
require 'dotenv'

Dotenv.load

Jimmys.db = Sequel.connect(ENV['DATABASE_URL'])
run Jimmys
