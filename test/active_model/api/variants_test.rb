# encoding: utf-8
require File.expand_path('../../../test_helper', __FILE__)

require 'active_model/messages_patch'

class ActiveModelApiVariantsTest < Test::Unit::TestCase
  class Model
    include ActiveModel::Validations
    attr_reader :foo
    def self.name; 'Model'; end
  end

  def setup
    I18n.backend.send(:init_translations) # i.e. don't overwrite our translations
  end

  def teardown
    I18n.backend = nil
    Model.reset_callbacks(:validate)
  end

  def error_on(attribute)
    model = Model.new
    model.valid?
    model.errors[attribute].first
  end

  test "variants: it picks a translation message variant from the messages namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end
  
  test "variants: it picks a translation message variant from the models namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.models.model.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end
  
  test "variants: it picks a translation message variant from the attributes namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.models.model.attributes.foo.blank' => { :short => 'short', :full => 'full' })
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end
  
  # given a :message String in class level validation macros

  test "variants: given a class level :message Hash of Strings it picks a variant" do
    Model.validates_presence_of :foo, :message => { :short => 'short', :full => 'full' }
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end

  # given a :message Symbol in class level validation macros

  test "variants: given a class level :message Symbol it translates the Symbol (message namespace) and picks a variant" do
    store_translations(:'errors.messages.broken' => { :short => 'short', :full => 'full' })
    Model.validates_presence_of :foo, :message => :broken
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end

  test "variants: given a class level :message Symbol it translates the Symbol (model namespace) and picks a variant" do
    store_translations(:'errors.models.model.broken' => { :short => 'short', :full => 'full' })
    Model.validates_presence_of :foo, :message => :broken
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end

  test "variants: given a class level :message Symbol it translates the Symbol (attribute namespace) and picks a variant" do
    store_translations(:'errors.models.model.attributes.foo.broken' => { :short => 'short', :full => 'full' })
    Model.validates_presence_of :foo, :message => :broken
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end

  # given a :message Proc returning a String in class level validation macros

  # FIXME does not pass
  #
  # test "variants: given a class level :message Proc returning a Hash of variant Strings it picks a variant" do
  #   Model.validates_presence_of :foo, :message => proc { { :short => 'short', :full => 'full' } }
  #   assert_equal "short", error_on(:foo).to_s
  #   assert_equal "short", error_on(:foo).to_s(:short)
  #   assert_equal "full",  error_on(:foo).to_s(:full)
  # end

  # given a :message Proc returning a Symbol in class level validation macros

  test "variants: given a class level :message Proc returning a Symbol it translates the Symbol (message namespace) and picks a variant" do
    store_translations(:'errors.messages.broken' => { :short => 'short', :full => 'full' })
    Model.validates_presence_of :foo, :message => proc { :broken }
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end

  test "variants: given a class level :message Proc returning a Symbol it translates the Symbol (model namespace) and picks a variant" do
    store_translations(:'errors.models.model.broken' => { :short => 'short', :full => 'full' })
    Model.validates_presence_of :foo, :message => proc { :broken }
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end
  
  test "variants: given a class level :message Proc returning a Symbol it translates the Symbol (attribute namespace) and picks a variant" do
    store_translations(:'errors.models.model.attributes.foo.broken' => { :short => 'short', :full => 'full' })
    Model.validates_presence_of :foo, :message => proc { :broken }
    assert_equal "short", error_on(:foo).to_s
    assert_equal "short", error_on(:foo).to_s(:short)
    assert_equal "full",  error_on(:foo).to_s(:full)
  end
end