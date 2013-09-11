require 'rest_client'
require 'json'

class MySupplier

  def initialize(cro='06630234')
    user = ENV['API_USER']
    pass = ENV['API_SECRET']

    cro = '06630234' if cro == ""
    @resource = RestClient::Resource.new 'https://data.amee.com/api/companies', user, pass
    response = @resource["#{cro}?type=CRO"].get
    @company = JSON.parse(response)["company"]
    #{"amee_company_id"=>"000662801", "name"=>"Amee UK Ltd", "amee_industry_score"=>100, "amee_score_status"=>"deprecated", "annual_sales_local"=>1979000, "city"=>"London", "country_code"=>"GB", "currency_code"=>"GBP", "emissions_scope1_tco2e"=>2, "emissions_scope2_tco2e"=>19, "emissions_status"=>"updated", "emissions_total_tco2e"=>21, "employees_total"=>17, "uk_sic_2007"=>62090, "national_identification_number"=>"06630234", "postcode"=>"EC1Y 2BJ", "province_name"=>"London", "street_address_1"=>"70/74 City Road", "street_address_2"=>nil, "street_address_3"=>nil, "street_address_4"=>nil, "sustainability_report_url"=>"http://blog.amee.com/wp-content/uploads/2013/02/Sustainability-Report-Final1.pdf", "sustainability_report_year"=>2013, "total_assets_local"=>1025000, "waste_hazardous_kg"=>nil, "waste_non_hazardous_kg"=>nil, "waste_status"=>"no_data", "water_status"=>"no_data", "water_withdrawn_l"=>nil, "amee_industry_score_icon"=>"http://s3.amazonaws.com/profile-production-public/score_images/style1/100.png", "line_of_business"=>"Other information technology and computer service activities", "lat"=>51.52492142, "lon"=>-0.08793893}
  end

  def details
    @company
  end

  def greener_alternatives
    response = @resource["?uk_sic_2007=#{@company["uk_sic_2007"]}&min_score=#{@company["amee_industry_score"]}"].get
    companies = []
    companies += JSON.parse(response)["companies"]
    companies.delete_if {|x| x["amee_company_id"] == @company["amee_company_id"] }
    return companies[0..2]
  end

end