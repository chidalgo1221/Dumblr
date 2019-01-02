# Run this script with `bundle exec ruby seeds.rb`

require 'active_record'

#require model classes
# require './models/cake.rb'

# Use `binding.pry` anywhere in this script for easy debugging
require 'pry'
require 'csv'

# Connect to a sqlite3 database
# If you feel like you need to reset it, simply delete the file sqlite makes
if ENV['DATABASE_URL']
  require 'pg'
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
  require 'sqlite3'
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.db'
)
end
# do stuff to store initial data