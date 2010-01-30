# encoding: utf-8
require File.expand_path(File.dirname(__FILE__)) + '/test_helper'

$:.unshift('~/Development/shared/rails/rails-master/activemodel/lib')
$:.unshift('~/Development/shared/rails/rails-master/activesupport/lib')

require 'active_model/messages_patch'

class Model
  include ActiveModel::Validations
  attr_reader :foo
end

class ActiveModelValidationStringTest < Test::Unit::TestCase
  class Error < ActiveModel::Error
    class Format < I18n::String::Format
      include I18n::String::Translated
    end

    include Translated, Cascade, Variants, Formatted

    self.format_class = Format
    self.cascade_options = { :step => 2, :skip_root => false, :scopes => [:model, :attribute] }
  end

  def setup
    I18n.backend  = CascadingBackend.new
    I18n.backend.send(:init_translations) # so our translations won't be overwritten by Rails
  end

  def teardown
    I18n.backend  = nil
    Model.reset_callbacks(:validate)
    ActiveModel::Errors.error_class = Error
  end

  def model
    model = Model.new
    model.valid?
    model
  end

  test "uses a class level String message" do
    Model.validates_presence_of :foo, :message => 'message'
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses class level String message formats" do
    Model.validates_presence_of :foo, :message => { :short => 'short', :full => 'full'}
    assert_equal "short", model.errors[:foo].first.to_s
    assert_equal "short", model.errors[:foo].first.to_s(:short)
    assert_equal "full",  model.errors[:foo].first.to_s(:full)
  end

  test "uses a translation from the messages namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.blank' => 'message')
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses translation message formats the messages namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", model.errors[:foo].first.to_s
    assert_equal "short", model.errors[:foo].first.to_s(:short)
    assert_equal "full", model.errors[:foo].first.to_s(:full)
  end

  test "uses a translation from a model namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.models.model.blank' => 'message')
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses translation message formats from a model namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.models.model.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", model.errors[:foo].first.to_s
    assert_equal "short", model.errors[:foo].first.to_s(:short)
    assert_equal "full", model.errors[:foo].first.to_s(:full)
  end

  test "uses a translation from an attribute namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.models.model.attributes.foo.blank' => 'message')
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses translation message formats from an attribute namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.models.model.attributes.foo.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", model.errors[:foo].first.to_s
    assert_equal "short", model.errors[:foo].first.to_s(:short)
    assert_equal "full", model.errors[:foo].first.to_s(:full)
  end

  test "interpolates validation data to a default message" do
    Model.validates_length_of :foo, :minimum => 1
    assert_equal "is too short (minimum is 1 characters)", model.errors[:foo].first.to_s
  end

  test "interpolates validation data to a class level String message" do
    Model.validates_length_of :foo, :minimum => 1, :message => '%{count}'
    assert_equal "1", model.errors[:foo].first.to_s
  end
end