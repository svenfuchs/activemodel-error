# # encoding: utf-8
# require File.expand_path(File.dirname(__FILE__)) + '/test_helper'
# require 'error'
#
# class CascadeTest < Test::Unit::TestCase
#   def setup
#     I18n.backend  = CascadingBackend.new
#     Error.cascade = { :step => 1, :skip_root => false }
#   end
#
#   def teardown
#     I18n.backend  = nil
#     Error.cascade = false
#   end
#
#   test "returns message from attribute scope if defined" do
#     I18n.backend.store_translations(:en, :errors => { :messages => { :models => { :model => { :attributes => { :attribute => { :email => 'No email?' } } } } } })
#     assert_equal 'No email?', Error.new(:email, 'model', :attribute, :email).to_s
#   end
#
#   test "returns message from model scope if defined" do
#     I18n.backend.store_translations(:en, :errors => { :messages => { :models => { :model => { :email => 'No email?' } } } })
#     assert_equal 'No email?', Error.new(:email, 'model', :attribute, :email).to_s
#   end
#
#   test "returns message from errors scope if defined" do
#     I18n.backend.store_translations(:en, :errors => { :messages => { :email => 'No email?' } })
#     assert_equal 'No email?', Error.new(:email, 'model', :attribute, :email).to_s
#   end
# end