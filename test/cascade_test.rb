# encoding: utf-8
require File.expand_path(File.dirname(__FILE__)) + '/test_helper'
require 'message'

class CascadingBackend < I18n::Backend::Simple
  include I18n::Backend::Cascade
end

class CascadeTest < Test::Unit::TestCase
  def setup
    I18n.backend = CascadingBackend.new
  end
  
  def teardown
    I18n.backend = I18n::Backend::Simple.new
  end
  
  test "returns message from attribute scope if defined" do
    I18n.backend.store_translations(:en, :errors => { :model => { :attribute => { :blank => 'No email?' } } })
    assert_equal 'No email?', Error.new(:blank, 'model', :attribute, :blank, :cascade => true).to_s(:short)
  end
  
  test "returns message from model scope if defined" do
    I18n.backend.store_translations(:en, :errors => { :model => { :blank => 'No email?' } })
    assert_equal 'No email?', Error.new(:blank, 'model', :attribute, :blank, :cascade => true).to_s(:short)
  end
  
  test "returns message from errors scope if defined" do
    I18n.backend.store_translations(:en, :errors => { :blank => 'No email?' })
    assert_equal 'No email?', Error.new(:blank, 'model', :attribute, :blank, :cascade => true).to_s(:short)
  end
end