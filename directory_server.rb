require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/directory_server.db")

class Person
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :required => true
  property :title, Text
end

DataMapper.finalize.auto_upgrade!

get '/' do
  "hello world!"
end

get '/create' do
  erb :create
end

post '/create' do
  unless Person.first(:name => params[:name])
    person = Person.new
    person.name = params[:name]
    person.title = params[:title]
    person.save
    "#{params[:name]}, #{params[:title]} has been created!"
  else
    "#{params[:name]} already exists!"
  end
end

get '/people' do
  @people = Person.all
  erb :people
end

delete '/people' do
  Person.destroy
  redirect to ('/people')
end
