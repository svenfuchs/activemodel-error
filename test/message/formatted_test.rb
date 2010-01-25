# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require 'message'

class MessageFormattedTest < Test::Unit::TestCase
  class Message < ::Message
    include Formatted
  end

  test "uses a full message format to wrap a short message" do
    I18n.backend.store_translations(:en, :'blank' => 'blank')
    I18n.backend.store_translations(:en, :'errors.formats.full' => 'something {{message}}')
    assert_equal "something blank", Message.new(:blank, nil).to_s(:full)
  end
end