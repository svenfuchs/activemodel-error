# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class I18nStringCascadeTest < Test::Unit::TestCase
  class String < I18n::String
    include Cascade
  end

  def setup
    I18n.backend  = CascadingBackend.new
    String.cascade_options = { :step => 2, :skip_root => false, :scopes => [:model, :attribute] }
  end
  
  include Behavior::Base
  include Behavior::Cascade
end

class I18nStringCascadeVariantsTest < I18nStringCascadeTest
  class String < I18nStringCascadeTest::String
    include Variants
  end

  include Behavior::Variants
end

