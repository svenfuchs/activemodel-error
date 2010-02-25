# encoding: utf-8
require File.expand_path(File.dirname(__FILE__)) + '/test_helper'

$:.unshift('~/Development/shared/rails/rails-master/activemodel/lib')
$:.unshift('~/Development/shared/rails/rails-master/activesupport/lib')
$:.unshift('~/Projects/Ruby/rails/activemodel/lib')
$:.unshift('~/Projects/Ruby/rails/activesupport/lib')

require 'active_model/errors_ext'

class Model
  include ActiveModel::Validations
  attr_reader :foo
end

module ActiveModelValidationStringTestSetup

  def setup
    I18n.backend  = CascadingBackend.new
    I18n.backend.send(:init_translations) # so our translations won't be overwritten by Rails
  end

  def teardown
    I18n.backend  = nil
    Model.reset_callbacks(:validate)

  end

  def model
    model = Model.new
    model.valid?
    model
  end

end

class LegacyActiveModelValidationStringTest < Test::Unit::TestCase
  include ActiveModelValidationStringTestSetup

  class Error < ActiveModel::Error
    include Legacy
  end

  def setup
    super
    ActiveModel::Errors.error_class = Error
  end

  test "uses a translation from the messages namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.blank' => 'message')
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses a translation from the messages namespace with a Proc" do
    Model.validates_presence_of :foo, :message => proc { :foo }
    store_translations(:'errors.messages.foo' => 'message')
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses a translation from a model namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.models.model.blank' => 'message')
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses a translation from an attribute namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.models.model.attributes.foo.blank' => 'message')
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "interpolates validation data to a default message" do
    Model.validates_length_of :foo, :minimum => 1
    assert_equal "is too short (minimum is 1 characters)", model.errors[:foo].first.to_s
  end

  test "AttributeErrors supports common methods" do
    store_translations(:'errors.messages.blank' => 'message')

    errors = model.errors[:foo]
    assert errors.empty?
    assert !errors.any?

    errors << :blank
    assert !errors.empty?
    assert errors.any?
    assert errors.include?(:blank)
    assert errors.include?("message")
    assert_equal "message", errors.first.to_s
  end

  test "errors added directly to AttributeErrors are accesible via Errors" do
    foo = model
    foo.errors[:bar] << :blank

    assert_equal 1, foo.errors.size
    assert_equal ['Bar can\'t be blank'], foo.errors.to_a
  end


=begin
  test "uses translation message formats from a model namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.models.model.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", model.errors[:foo].first.to_s
    assert_equal "short", model.errors[:foo].first.to_s(:short)
    assert_equal "full", model.errors[:foo].first.to_s(:full)
  end


  test "uses translation message formats from an attribute namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.models.model.attributes.foo.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", model.errors[:foo].first.to_s
    assert_equal "short", model.errors[:foo].first.to_s(:short)
    assert_equal "full", model.errors[:foo].first.to_s(:full)
  end
=end

end

class ActiveModelValidationStringTest < Test::Unit::TestCase

  include ActiveModelValidationStringTestSetup

  class Error < ActiveModel::Error
    include Cascade, Variants, Formatted

    self.cascade_options = { :step => 2, :skip_root => false, :scopes => [:model, :attribute] }
  end

  def setup
    super
    ActiveModel::Errors.error_class = Error
  end

  test "uses a class level String message" do
    Model.validates_presence_of :foo, :message => 'message'
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses a class level Proc message" do
    Model.validates_presence_of :foo, :message => proc {'message'}
    assert_equal "message", model.errors[:foo].first.to_s
  end

  test "uses class level String message formats" do
    Model.validates_presence_of :foo, :message => { :short => 'short', :full => 'full'}
    assert_equal "short", model.errors[:foo].first.to_s
    assert_equal "short", model.errors[:foo].first.to_s(:short)
    assert_equal "full",  model.errors[:foo].first.to_s(:full)
  end

=begin
  test "uses translation message formats the messages namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", model.errors[:foo].first.to_s
    assert_equal "short", model.errors[:foo].first.to_s(:short)
    assert_equal "full", model.errors[:foo].first.to_s(:full)
  end
=end

  test "interpolates validation data to a class level String message" do
    Model.validates_length_of :foo, :minimum => 1, :message => '%{count}'
    assert_equal "1", model.errors[:foo].first.to_s
  end

  test "returns an instance of AttributeErrors" do
    Model.validates_presence_of :foo
    assert model.errors[:foo].is_a?(ActiveModel::AttributeErrors)
  end

end