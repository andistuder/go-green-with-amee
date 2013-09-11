require 'sinatra'
require 'rest_client'
require 'haml'

require_relative 'my_supplier.rb'

get '/' do
  haml :index
end


post '/go_green' do
  response = MySupplier.new(params["cro"])
  @my_supplier = response.details
  @my_alternatives = response.greener_alternatives
  haml :go_red
end

