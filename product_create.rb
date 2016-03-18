require 'sinatra'
require 'sinatra/config_file'

set :lock, true
config_file './config/config.yml'

post '/' do
`"#{settings.app_path}" "/r" "#{settings.workflow_path}"` 
end


