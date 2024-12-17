require 'sinatra'
require_relative 'api/base'

class App < Sinatra::Base
  set :public_folder, 'public'

  get '/api' do
    run API::Base
  end

  get '/openaccess/docs' do
    redirect '/swagger-ui/index.html'
  end
end
