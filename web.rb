require 'sinatra'
require 'rest_client'
require 'haml'

require_relative 'company.rb'

get '/' do
  haml :index
end


post '/go_green' do

  resource = RestClient::Resource.new 'https://data.amee.com/api/companies', ENV['API_USER'], ENV['API_SECRET']

  @my_supplier = Company.new(resource).find_my_supplier!(params["cro"])
  @my_alternatives = @my_supplier.find_greener_alternatives!
  haml :go_red
end
