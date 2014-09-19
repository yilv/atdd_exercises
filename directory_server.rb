require 'sinatra'
require_relative 'person'

get '/' do
  "hello world!"
end

get '/create' do
  erb :create
end

post '/create' do
  person = Person.new(params[:name], params[:title])
  if person.existing_name
    "#{params[:name]} already exists!"
  elsif person.invalid_name
    "Invalid name!"
  elsif person.invalid_title
    "Invalid title!"
  else
    person.save
    "#{person.name}, #{person.title} has been created!"
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
