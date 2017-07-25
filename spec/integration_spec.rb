require('capybara/rspec')
require('./app')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

before() do
  test_company = Company.create({:name => 'Kplc'})
  test_user = User.create({:name => 'Najib'})
end
