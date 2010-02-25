# FIXME personal load paths
$:.unshift('~/Development/shared/rails/rails-master/activemodel/lib')
$:.unshift('~/Development/shared/rails/rails-master/activesupport/lib')
$:.unshift('~/Projects/Ruby/rails/activemodel/lib')
$:.unshift('~/Projects/Ruby/rails/activesupport/lib')


$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
$:.unshift(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'test/unit'
require 'test_case_declarative'

require 'activemodel_error'

class Test::Unit::TestCase
  def teardown
    I18n.backend  = nil
  end

  def store_translations(data)
    I18n.backend.store_translations(:en, data)
  end
end

class CascadingBackend < I18n::Backend::Simple
  include I18n::Backend::Cascade
end
