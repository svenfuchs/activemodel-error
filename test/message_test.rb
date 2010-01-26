# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/test_helper')
require 'message'

class MessageTest < Test::Unit::TestCase
  def setup
    I18n.backend = I18n::Backend::Simple.new
  end
  
  def message(*args)
    Message.new(*args)
  end

  include Behavior::Message::Common
  include Behavior::Message::NonFormatted
end