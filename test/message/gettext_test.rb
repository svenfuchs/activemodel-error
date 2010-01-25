# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MessageGettextTest < Test::Unit::TestCase
  class Message < ::Message
    include Message::Gettext
  end

  test "Message.new is a String, will be translated" do
    I18n.backend.store_translations(:en, 'Message' => 'The Message.new')
    assert_equal 'The Message.new', Message.new(:blank, 'Message').to_s
  end
  
end