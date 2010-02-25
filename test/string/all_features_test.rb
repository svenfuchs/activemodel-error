# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class AllFeaturesTest < Test::Unit::TestCase
  class Format < I18n::Message::Format
    include I18n::Message::Variants
  end

  class Message < I18n::Message
    include Cascade
    include Variants
    include Formatted

    self.format_class = Format
  end

  def setup
    I18n.backend  = CascadingBackend.new
    Message.cascade_options = { :step => 2, :skip_root => false, :scopes => [:model, :attribute] }
  end
  
  include Behavior::Base
  include Behavior::Cascade
  include Behavior::Variants
  include Behavior::Formatted
end