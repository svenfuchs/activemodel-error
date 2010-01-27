# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class MessageCascadeTest < Test::Unit::TestCase
  class Message < ::Message
    include Cascade
    # Cascade already includes Translated, too
  end

  def setup
    I18n.backend  = CascadingBackend.new
    Message.cascade_options = { :step => 2, :skip_root => false, :scopes => [:model, :attribute] }
  end
  
  include Behavior::Base
  include Behavior::Translated
  include Behavior::Cascade
end

class MessageCascadeVariantsTest < MessageCascadeTest
  class Message < MessageCascadeTest::Message
    include Variants
  end

  include Behavior::Variants
end

