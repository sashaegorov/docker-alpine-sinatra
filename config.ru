$LOAD_PATH.unshift(File.dirname(__FILE__))

at_exit do
  puts <<~M
    Damn!
    It seems someone has visited `/exit` or triggered TERM signal.
    Exiting...
  M
  exit false
end

require 'app'
run App
