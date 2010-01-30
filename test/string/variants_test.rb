# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class I18nStringVariantsTest < Test::Unit::TestCase
  class String < I18n::String
    include Variants
  end

  include Behavior::Base
  include Behavior::Variants
end