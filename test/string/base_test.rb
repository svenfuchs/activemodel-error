# encoding: utf-8
require File.expand_path('../../test_helper', __FILE__)

class I18nStringBaseTest < Test::Unit::TestCase
  class String < I18n::String
  end

  def setup
    I18n.backend = I18n::Backend::Simple.new
    I18n.backend.send(:init_translations) # so our translations won't be overwritten by Rails
  end

  include Behavior::Base
  # include Behavior::NonFormatted
end