require 'simplecov' 

SimpleCov.start do 
  add_filter 'test/'
end 

require "minitest"
require "minitest/autorun"
require "minitest/reporters"
require "minitest/pride"

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../lib/room"
require_relative "../lib/hotel"
require_relative "../lib/reservation"
require_relative "../lib/block"
require_relative "../lib/daterange"