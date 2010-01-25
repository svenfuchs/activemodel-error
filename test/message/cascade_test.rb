# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MessageCascadeTest < Test::Unit::TestCase
  class Message < ::Message
    include Cascade
    def options
      super.merge(:scope => :'errors.messages.models.model.attributes.attribute')
    end
  end

  def setup
    I18n.backend  = CascadingBackend.new
  end

  def teardown
    I18n.backend  = nil
  end

  test "returns message from attribute scope" do
    I18n.backend.store_translations(:en, :'errors.messages.models.model.attributes.attribute.message' => 'message')
    assert_equal 'message', Message.new(:message).to_s
  end

  test "returns message from model scope" do
    I18n.backend.store_translations(:en, :'errors.messages.models.model.message' => 'message')
    assert_equal 'message', Message.new(:message).to_s
  end

  test "returns message from errors scope" do
    I18n.backend.store_translations(:en, :'errors.messages.message' => 'message')
    assert_equal 'message', Message.new(:message).to_s
  end
end