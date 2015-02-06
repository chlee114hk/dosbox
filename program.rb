$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/app")

require 'dosbox'
require 'pp'

configurator = Configurator.new
configurator.configurate_system