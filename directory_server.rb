require 'sinatra'
require_relative 'person'

get '/' do
  "hello world!"
end

get '/create' do
  erb :create
end

post '/create' do
  if Person.existing_name(params[:name])
    "#{params[:name]} already exists!"
  elsif Person.invalid_name(params[:name])
    "Invalid name!"
  elsif Person.invalid_title(params[:title])
    "Invalid title!"
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
