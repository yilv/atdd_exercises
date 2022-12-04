require "rspec"
require_relative "../../person"

When(/^create a person \"(.*)\", \"(.*)\"$/) do |name, title|
  visit 'http://localhost:4567/create'
  fill_in 'name', :with => name
  fill_in 'title', :with => title
  click_button 'Create'
  sleep(0.5)
end

Then(/^see \"(.*?)\"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^the person \"(.*)\", \"(.*)\" exists$/) do |name, title|
  visit 'http://localhost:4567/people'
  within_table('people') do
    expect(first('tr', :text => name)).to have_content(title)
  end
end

Given(/^delete all people$/) do
  visit 'http://localhost:4567/people'
  click_button 'Delete All!'
  wait_for(Person.count).to eq(0)
end
