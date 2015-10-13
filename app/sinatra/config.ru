$LOAD_PATH.unshift(File.dirname(__FILE__))

at_exit do
  puts 'Damn!'
  exit false
end

require 'app'
run App
