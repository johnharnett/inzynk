require 'sinatra'
require 'sinatra/config_file'
require 'nokogiri'
require 'json'

set :lock, true
set :raise_errors, true

config_file './config/config.yml'

def create_product product
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.Company('xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance','xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema') {
      xml.Products {
      xml.Product {
            product.keys.each do |key|
                  xml.send(key,product[key])
            end
             }
         }
     }
  end
  builder.to_xml
end

before do
    request.body.rewind
    @request_payload = JSON.parse request.body.read
end

post '/' do

  the_product_xml = create_product  @request_payload
   

  # File.open("#{settings.workflow_path}","w") do |f|
  #  contents = f.read
  #  parse contents
  #  update contents to put in workflow variables such as file name
  # f.write contents
  # end

  File.open("c:\\temp\\test_127_stock_record_min.xml","w") do |f| #  puts "writing file"
    f.write the_product_xml
  end

  x = `"#{settings.app_path}" "/r" "#{settings.workflow_path}"` 
  # wait for  update workflow to finish
  # parse x? to generate status code?
  201

end
 
 
post '/test' do
   p create_product @request_payload
   201
end


