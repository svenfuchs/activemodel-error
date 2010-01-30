# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class I18nStringFormattedTest < Test::Unit::TestCase
  class Format < I18n::String::Format
    include I18n::String::Variants
  end

  class String < I18n::String
    include Formatted
    self.format_class = Format
  end

  include Behavior::Base
  include Behavior::Formatted
end