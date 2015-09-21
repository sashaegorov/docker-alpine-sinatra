require 'sinatra'
require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    'Hello from Sinatra in Docker!'
  end

  # Show environment info
  get '/env' do
    'Environment:' +
    '<ul>' +
    ENV.each.map { |k,v| "<li><strong>#{k}:</strong> #{v}</li>" }.join +
    '</ul>'
  end

  # Exit 'correctly'
  get '/exit' do
    # /exit causes:
    # 15:20:24 web.1  | Damn!
    # 15:20:24 web.1  | exited with code 1
    Process.kill('TERM', Process.pid)
  end

  # Just terminate
  get '/fail' do
    Process.kill('KILL', Process.pid)
  end

  # Artificial delay...
  get '/sleep' do
    # Just sleep...
    seconds = params[:seconds].to_f || 1.0
    sleep seconds
    "Wasted #{seconds} sec.<br/><strong>ProTip:</strong> use `/sleep?seconds=3`"
  end
end
