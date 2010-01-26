# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require 'message'

class MessageFormattedTest < Test::Unit::TestCase
  class Message < ::Message
    include Formatted
  end
  
  def setup
    store_translations(:'errors.formats' => { :short => '{{message}}', :full => 'full {{message}}' })
  end

  include Behavior::Message::Common
  include Behavior::Formatted
end