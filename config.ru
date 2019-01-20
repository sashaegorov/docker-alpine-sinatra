$LOAD_PATH.unshift(File.dirname(__FILE__))

at_exit do
  puts <<~MESSAGE
    Damn!
    It seems someone has visited `/exit` or triggered TERM signal.
    Exiting...
  MESSAGE
  exit false
end

require 'app'
run App
