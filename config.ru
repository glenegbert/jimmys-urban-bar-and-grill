require './jimmys'
require 'sequel'

unless ENV['DATABASE_URL'] { require 'dotenv'; Dotenv.load }

Jimmys.db = Sequel.connect(ENV['DATABASE_URL'])
run Jimmys
