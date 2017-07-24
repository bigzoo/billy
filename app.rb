require("bundler/setup")
Bundler.require(:default)
require('pry')
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

#Route to the index
get("/") do
  erb(:index)
end
