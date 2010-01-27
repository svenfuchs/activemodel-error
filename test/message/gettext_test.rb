# # encoding: utf-8
# require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
#
# class MessageGettextTest < Test::Unit::TestCase
#   class Message < ::Message
#     include Message::Gettext
#   end
#
#   def setup
#     store_translations(
#       :foo      => 'foo',
#       :message  => 'message',
#       :'%{foo}' => '%{foo}'
#     )
#   end
#
#   include Behavior::Message::Common
#   include Behavior::Message::NonFormatted
#   include Behavior::Gettext
# end