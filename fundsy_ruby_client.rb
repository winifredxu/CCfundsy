require "faraday"

conn = Faraday.new(:url => "http://localhost:3000") do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

#response = conn.get "/campaigns/1542" # regular controller and this gives entire HTML
response = conn.get "/api/v1/campaigns/1542" #only JSON controller/view


puts ">>>>>>>>>>>>>>>>>>>>>"
puts response.body
puts "============================"

puts "request.remote_ip: #{request.remote_ip}"