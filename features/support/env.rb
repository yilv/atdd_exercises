require 'capybara/cucumber'
require "rspec/wait"

World(RSpec::Wait)

Capybara.default_driver = :selenium

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
