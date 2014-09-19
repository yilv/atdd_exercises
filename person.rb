require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/person.db")

class Person
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :required => true
  property :title, Text

  def initialize(name, title)
    self.name = name
    self.title = title
  end

  def existing_name
    Person.first(:name => name)
  end

  def invalid_name
    (name =~ /^[^a-zA-Z]/) || (name.size > 20)
  end

  def invalid_title
    if (title == "") then return false end
    !(title =~ /Coach|Developer/)
  end
end

DataMapper.finalize.auto_upgrade!
