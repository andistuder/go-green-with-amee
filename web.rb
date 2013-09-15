require 'sinatra'
require 'rest_client'
require 'haml'

require_relative 'company.rb'

get '/' do
  haml :index
end


post '/go_green' do
  @my_supplier = Company.new.find_my_supplier(params["cro"])
  @my_alternatives = @my_supplier.greener_alternatives
  haml :go_red
end

