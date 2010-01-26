# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MessageCascadeTest < Test::Unit::TestCase
  class Message < ::Message
    include Cascade
    def options
      super.merge(:scope => :'models.model.attributes.attribute') 
    end
  end

  def setup
    I18n.backend  = CascadingBackend.new
    Message.cascade_options = { :step => 2, :skip_root => false }
  end
  
  include Behavior::Message::Common
  include Behavior::Message::NonFormatted
  include Behavior::Cascade
end

class MessageCascadeVariantsTest < MessageCascadeTest
  class Message < MessageCascadeTest::Message
    include Variants
  end

  include Behavior::Variants
end

