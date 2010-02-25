# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class I18nMessageFormattedTest < Test::Unit::TestCase
  class Format < I18n::Message::Format
    include I18n::Message::Variants
  end

  class Message < I18n::Message
    include Formatted
    self.format_class = Format
  end

  include Behavior::Base
  include Behavior::Formatted
end