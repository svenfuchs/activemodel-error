# setup: 
#
#   git clone rails
#   gem install bundler
#   gem bundle  (i had to comment out gem "pg", ">= 0.8.0" from rails/Gemfile)
#   cd activemodel
#   rake
#   => should run the activemodel tests (outputs a ton of warnings for me)
#
#   update line the following line, then running this file should run validations tests

dir = File.expand_path('~/Development/shared/rails/rails-master/activemodel')
$:.unshift "#{dir}/lib", "#{dir}/test"

require File.expand_path('../../test_helper', __FILE__)
require 'active_model/messages_patch'

tests = Dir["#{dir}/test/cases/validations{/**/*,}_test.rb"]
# tests = Dir["#{dir}/test/cases/validations_test.rb"]
tests.each { |test| require test }

