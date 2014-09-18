require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/directory_server.db")

class Person
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :required => true
  property :title, Text

  def self.existing_name(name)
    Person.first(:name => name)
  end
end

DataMapper.finalize.auto_upgrade!

get '/' do
  "hello world!"
end

get '/create' do
  erb :create
end

post '/create' do
  if Person.existing_name(params[:name])
    "#{params[:name]} already exists!"
  else
    person = Person.new
    person.name = params[:name]
    person.title = params[:title]
    person.save
    "#{params[:name]}, #{params[:title]} has been created!"
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
