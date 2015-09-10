require 'sinatra'
require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    '<h1>Hello from Sinatra in Docker!</h1>'
  end
end
