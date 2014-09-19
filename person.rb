require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/person.db")

class Person
  include DataMapper::Resource
  property :id, Serial
  property :name, Text, :required => true
  property :title, Text

  def self.existing_name(name)
    Person.first(:name => name)
  end

  def self.invalid_name(name)
    (name =~ /^[^a-zA-Z]/) || (name.size > 20)
  end

  def self.invalid_title(title)
    if (title == "") then return false end
    !(title =~ /Coach|Developer/)
  end
end

DataMapper.finalize.auto_upgrade!
