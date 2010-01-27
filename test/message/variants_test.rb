# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MessageVariantsTest < Test::Unit::TestCase
  class Message < ::Message
    include Variants
  end

  include Behavior::Base
  include Behavior::Variants
end