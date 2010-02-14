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

dirs = %w(
  ~/Development/shared/rails/rails-master/activemodel
  ~/Projects/Ruby/rails/activemodel/
).map { |dir| File.expand_path(dir) }

dirs.each { |dir| $:.unshift "#{dir}/lib", "#{dir}/test" }
$:.unshift('~/Projects/Ruby/rails/activesupport/lib')

require File.expand_path('../../test_helper', __FILE__)
require 'active_model/messages_patch'
require 'core_ext/error_comparsion'

class ActiveModel::Error
  include Legacy
end

tests = dirs.map { |dir| Dir["#{dir}/test/cases/validations{/**/*,}_test.rb"] }.flatten
# tests = Dir["#{dir}/test/cases/validations_test.rb"]
# tests.reject! { |test| test.include?('i18n_validation_test.rb') }
tests.each { |test| require test }

