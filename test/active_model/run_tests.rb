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
dir = File.expand_path('~/Projects/Ruby/rails/activemodel/')
$:.unshift "#{dir}/lib", "#{dir}/test"
$:.unshift('~/Projects/Ruby/rails/activesupport/lib')

require File.expand_path('../../test_helper', __FILE__)
require 'active_model/messages_patch'

class Array
  def equals_with_active_model_errors(other)
    other = other.map { |e| e.to_s } if ActiveModel::AttributeErrors === other
    equals_without_active_model_errors(other)
  end
  alias equals_without_active_model_errors ==
  alias == equals_with_active_model_errors
end

class String
  def equals_with_active_model_error(other)
    other = other.to_s if ActiveModel::Error === other
    equals_without_active_model_error(other)
  end
  alias equals_without_active_model_error ==
  alias == equals_with_active_model_error

  def compare_with_active_model_error(other)
    other = other.to_s if ActiveModel::Error === other
    compare_without_active_model_error(other)
  end
  alias compare_without_active_model_error <=>
  alias <=> compare_with_active_model_error
end

class ActiveModel::Error
  include Cascade, Variants, Formatted
  self.cascade_options = { :step => 2, :scopes => [:model, :attribute] }
end

I18n::Backend::Simple.send(:include, I18n::Backend::Cascade)

tests = Dir["#{dir}/test/cases/validations{/**/*,}_test.rb"]
# tests = Dir["#{dir}/test/cases/validations_test.rb"]
# tests.reject! { |test| test.include?('i18n_validation_test.rb') }
tests.each { |test| require test }


# errors.messages.models.person.attributes.title.custom_error
# errors.models.person.attributes.title.custom_error
