$LOAD_PATH.unshift(File.dirname(__FILE__))

at_exit do
  puts 'Damn! It seems someone has visited `/exit`. Exiting...'
  exit false
end

require 'app'
run App
