# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require 'message'

class MessageWithFormatted < Message
  include Formatted
end

class MessageFormattedTest < Test::Unit::TestCase
  def message(*args)
    MessageWithFormatted.new(*args)
  end
  
  test "uses a full message format to wrap a short message" do
    I18n.backend.store_translations(:en, :'blank' => 'blank')
    I18n.backend.store_translations(:en, :'errors.formats.full' => 'something {{message}}')
    assert_equal "something blank", message(:blank, nil).to_s(:full)
  end
end