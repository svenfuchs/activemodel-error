# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MessageFormattedTest < Test::Unit::TestCase
  class Format < ::Format
    include Message::Translated
  end

  class Message < ::Message
    include Translated
    include Formatted
    self.format_class = Format
  end

  include Behavior::Base
  include Behavior::Formatted
end