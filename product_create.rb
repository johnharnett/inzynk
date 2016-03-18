require 'sinatra'
require 'sinatra/config_file'
require 'nokogiri'

set :lock, true
set :raise_errors, true

config_file './config/config.yml'

def create_product sku
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.Company {
	    xml.Products {
	      xml.Product  {
		 xml.Sku sku.to_s
		 xml.Name "Awesome widget"
		 xml.Description "101.00"
		 xml.LongDescription "this is a test"
		 xml.SalePrice "101"
		 xml.Custom1 "201.00"
		 xml.Custom2 "221.00"
		 xml.Custom3 "223.00"
	      }  
            }  
          }
      end
      builder.to_xml
end


post '/' do

  the_product_xml = create_product "test_127"
  

  File.open("c:\\temp\\test_127_stock_record_min.xml","w") do |f| #  puts "writing file"
    f.write the_product_xml
  end

  x = `"#{settings.app_path}" "/r" "#{settings.workflow_path}"` 
  'success'

end
 
get '/' do
 'hello work worlds'
end
 


