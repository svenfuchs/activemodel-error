# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MessageWithCascade < Message
  include Cascade
  def options
    super.merge(:scope => :'errors.messages.models.model.attributes.attribute')
  end
end

class MessageCascadeTest < Test::Unit::TestCase
  def setup
    I18n.backend  = CascadingBackend.new
  end

  def teardown
    I18n.backend  = nil
  end

  def message(*args)
    MessageWithCascade.new(*args)
  end
  
  test "returns message from attribute scope" do
    I18n.backend.store_translations(:en, :'errors.messages.models.model.attributes.attribute.message' => 'message')
    assert_equal 'message', message(:message).to_s
  end

  test "returns message from model scope" do
    I18n.backend.store_translations(:en, :'errors.messages.models.model.message' => 'message')
    assert_equal 'message', message(:message).to_s
  end

  test "returns message from errors scope" do
    I18n.backend.store_translations(:en, :'errors.messages.message' => 'message')
    assert_equal 'message', message(:message).to_s
  end
end