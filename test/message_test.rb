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

  # e.g. validates_presence_of :email, :message => "message"
  test "message is a String, no format key given" do
    assert_equal 'message', message(:blank, 'message').to_s
  end

  test "message is a String, format key :short given" do
    assert_equal 'message', message(:blank, 'message').to_s(:short)
  end

  test "message is a String, format key :full given" do
    assert_equal 'message', message(:blank, 'message').to_s(:full)
  end

  # e.g. validates_presence_of :email / translations :blank => 'No email?'
  test "no message given, no format key given, translation is a String" do
    I18n.backend.store_translations(:en, :blank => 'No email?')
    assert_equal 'No email?', message(:blank).to_s
  end

  test "no message given, format key :short given, translation is a String" do
    I18n.backend.store_translations(:en, :blank => 'No email?')
    assert_equal 'No email?', message(:blank).to_s(:short)
  end

  test "no message given, format key :full given, translation is a String" do
    I18n.backend.store_translations(:en, :blank => 'No email?')
    assert_equal 'No email?', message(:blank).to_s(:full)
  end

  # e.g. validates_presence_of :email, :message => :foo / translations :foo => 'No email?'
  test "message is a Symbol, format key :short given, translation is a String" do
    I18n.backend.store_translations(:en, :foo => 'No email?')
    assert_equal 'No email?', message(:blank, :foo).to_s(:short)
  end

  test "message is a Symbol, format key :full given, translation is a String" do
    I18n.backend.store_translations(:en, :foo => 'No email?')
    assert_equal 'No email?', message(:blank, :foo).to_s(:full)
  end
  
  # INTERPOLATION

  test "message given as String, interpolates a variable" do
    assert_equal 'FOO', message(:foo, '%{foo}', :foo => 'FOO').to_s(:short)
  end

  test "message given as String, bogus interpolation variable, does not raise" do
    assert_nothing_raised { message(:foo, 'foo', :foo => 'FOO').to_s(:short) }
  end

  test "no message given, translation is a String, interpolates a variable" do
    I18n.backend.store_translations(:en, :foo => '{{foo}}')
    assert_equal 'FOO', message(:foo, nil, :foo => 'FOO').to_s
  end

end