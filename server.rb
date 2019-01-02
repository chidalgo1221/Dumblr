require 'sinatra'
require "sinatra/reloader"

# Run this script with `bundle exec ruby app.rb`
require 'sqlite3'
require 'active_record'

#require model classes
# require './models/cake.rb'
require './models/user.rb'
require './models/post.rb'
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

register Sinatra::Reloader
enable :sessions

get '/' do
  erb :login
end

get '/homepage' do
  @all_posts = Post.all
  erb :homepage
end

get '/login' do
  erb :login
end

post '/login' do 
  user = User.find_by(username: params["username"], password: params["password"])
  if user
    session[:user_id] = user.id
    redirect '/homepage'
  else
    redirect '/login'
  end
end

post '/signup' do
  people = User.create(first_name: params["first"], last_name: params["last"], email: params["email"], birthday: params["birthday"], username: params["username"], password: params["password"])
  session[:user_id] = people.id
  redirect '/homepage'
end

get '/logout' do 
  session[:user_id] = nil
  redirect '/'
end

get '/posts' do
  erb :homepage
end

post '/posts' do
  @new_post = Post.create(user_id: session[:user_id], post_text: params["post_text"])
  redirect '/homepage'
end

get '/deactivate' do
  erb :deactivate
end

get '/destroy' do
  @user = User.find(session[:user_id])
  @user.destroy
  redirect '/'
end

get '/profile' do 
  erb :profile
end