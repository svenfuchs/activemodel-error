# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MessageWithGettext < Message
  include Message::Gettext
end

class MessageGettextTest < Test::Unit::TestCase
  def message(*args)
    MessageWithGettext.new(*args)
  end
  
  test "message is a String, will be translated" do
    I18n.backend.store_translations(:en, 'Message' => 'The message')
    assert_equal 'The message', message(:blank, 'Message').to_s
  end
  
end