# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class I18nMessageVariantsTest < Test::Unit::TestCase
  class Message < I18n::Message
    include Variants
  end

  include Behavior::Base
  include Behavior::Variants
end