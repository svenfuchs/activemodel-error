# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class I18nMessageCascadeTest < Test::Unit::TestCase
  class Message < I18n::Message
    include Cascade
  end

  def setup
    I18n.backend  = CascadingBackend.new
    Message.cascade_options = { :step => 2, :skip_root => false, :scopes => [:model, :attribute] }
  end
  
  include Behavior::Base
  include Behavior::Cascade
end

class I18nMessageCascadeVariantsTest < I18nMessageCascadeTest
  class Message < I18nMessageCascadeTest::Message
    include Variants
  end

  include Behavior::Variants
end

