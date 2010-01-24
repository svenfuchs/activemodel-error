# encoding: utf-8
require File.expand_path(File.dirname(__FILE__)) + '/test_helper'
require 'message'

class MessageInterpolationTest < Test::Unit::TestCase
  test "message given as String, interpolates a variable" do
    assert_equal 'FOO', Message.new(:foo, '%{foo}').to_s(:short, :foo => 'FOO')
  end

  test "message given as String, bogus interpolation variable, does not raise" do
    assert_nothing_raised { Message.new(:foo, 'foo').to_s(:short, :foo => 'FOO') }
  end
end