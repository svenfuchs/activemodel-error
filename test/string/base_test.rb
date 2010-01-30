# encoding: utf-8
require File.expand_path('../../test_helper', __FILE__)

class I18nStringBaseTest < Test::Unit::TestCase
  class String < I18n::String
  end

  include Behavior::Base
  # include Behavior::NonFormatted
end