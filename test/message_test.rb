# # encoding: utf-8
# require File.expand_path(File.dirname(__FILE__)) + '/test_helper'
# require 'message'
#
# class MessageTest < Test::Unit::TestCase
#   def setup
#     I18n.backend = I18n::Backend::Simple.new
#   end
#
#   # validates_presence_of :email, :message => "No email?"
#   test "message is a String, format key :short given" do
#     assert_equal 'No email?', Message.new(:blank, 'No email?').to_s(:short)
#   end
#
#   test "message is a String, format key :full given" do
#     assert_equal 'No email?', Message.new(:blank, 'No email?').to_s(:full)
#   end
#
#   # validates_presence_of :email, :message => { :short => "No email?", :full => "What's your email?" } }
#   test "message is a Hash w/ :short and :full messages, format key :short given" do
#     assert_equal 'No email?', Message.new(:blank, :short => 'No email?', :full => "What's your email?").to_s(:short)
#   end
#
#   test "message is a Hash w/ :short and :full messages, format key :full given" do
#     assert_equal "What's your email?", Message.new(:blank, :short => 'No email?', :full => "What's your email?").to_s(:full)
#   end
#
#   # validates_presence_of :email / translations :blank => 'No email?'
#   test "no message given, format key :short given, translation is a String" do
#     I18n.backend.store_translations(:en, :blank => 'No email?')
#     assert_equal 'No email?', Message.new(:blank).to_s(:short)
#   end
#
#   test "no message given, format key :full given, translation is a String" do
#     I18n.backend.store_translations(:en, :blank => 'No email?')
#     assert_equal 'No email?', Message.new(:blank).to_s(:full)
#   end
#
#   # validates_presence_of :email / translations :blank => { :short => 'No email?' }
#   test "no message given, format key :short given, translation is a Hash w/ :short key" do
#     I18n.backend.store_translations(:en, :blank => { :short => 'No email?' })
#     assert_equal 'No email?', Message.new(:blank).to_s(:short)
#   end
#
#   # not implemented
#   # test "no message given, format key :full given, translation is a Hash w/ :short key" do
#   #   I18n.backend.store_translations(:en, :blank => { :short => 'No email?' })
#   #   assert_equal 'No email?', Message.new(:blank).to_s(:full)
#   # end
#
#   # validates_presence_of :email / translations :blank => { :short => 'No email?', :full => "What's your email?" }
#   test "no message given, format key :short given, translation is a Hash w/ :short and :full keys" do
#     I18n.backend.store_translations(:en, :blank => { :short => 'No email?', :full => "What's your email?" })
#     assert_equal 'No email?', Message.new(:blank).to_s(:short)
#   end
#
#   test "no message given, format key :full given, translation is a Hash w/ :short and :full keys" do
#     I18n.backend.store_translations(:en, :blank => { :short => 'No email?', :full => "What's your email?" })
#     assert_equal "What's your email?", Message.new(:blank).to_s(:full)
#   end
#
#   # validates_presence_of :email, :message => :foo / translations :foo => 'No email?'
#   test "message is a Symbol, format key :short given, translation is a String" do
#     I18n.backend.store_translations(:en, :foo => 'No email?')
#     assert_equal 'No email?', Message.new(:blank, :foo).to_s(:short)
#   end
#
#   test "message is a Symbol, format key :full given, translation is a String" do
#     I18n.backend.store_translations(:en, :foo => 'No email?')
#     assert_equal 'No email?', Message.new(:blank, :foo).to_s(:full)
#   end
#
#   # validates_presence_of :email, :message => { :short => :foo } / translations :blank => { :short => 'No email?' }
#   test "message is a Hash, format key :short given, translation is a Hash w/ :short key" do
#     I18n.backend.store_translations(:en, :foo => { :short => 'No email?' })
#     assert_equal 'No email?', Message.new(:blank, :short => :foo).to_s(:short)
#   end
#
#   # not implemented
#   # test "message is a Hash, format key :full given, translation is a Hash w/ :short key" do
#   #   I18n.backend.store_translations(:en, :foo => { :short => 'No email?' })
#   #   assert_equal 'No email?', Message.new(:blank, :short => :foo).to_s(:full)
#   # end
#
#   # validates_presence_of :email, :message => { :short => :foo, :full => :foo } / translations :blank => { :short => 'No email?' }
#   test "message is a Hash, format key :short given, translation is a Hash w/ :short and :full key" do
#     I18n.backend.store_translations(:en, :foo => { :short => 'No email?' })
#     assert_equal 'No email?', Message.new(:blank, :short => :foo, :full => :foo).to_s(:short)
#   end
#
#   # not implemented
#   # test "message is a Hash, format key :full given, translation is a Hash w/ :short and :full key" do
#   #   I18n.backend.store_translations(:en, :foo => { :short => 'No email?' })
#   #   assert_equal 'No email?', Message.new(:blank, :short => :foo, :full => :foo).to_s(:full)
#   # end
# end