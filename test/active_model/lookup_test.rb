# encoding: utf-8
require File.expand_path('../../test_helper', __FILE__)

class ActiveModelApiLookupTest < Test::Unit::TestCase
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

  # LOOKUP

  test "lookup: it returns a translation from the messages namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.messages.blank' => 'message')
    assert_equal "message", error_on(:foo).to_s
  end

  test "lookup: it returns a translation from the model namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.models.model.blank' => 'message')
    assert_equal "message", error_on(:foo).to_s
  end

  test "lookup: it returns a translation from the attribute namespace" do
    Model.validates_presence_of :foo
    store_translations(:'errors.models.model.attributes.foo.blank' => 'message')
    assert_equal "message", error_on(:foo).to_s
  end

  # given a :message Message in class level validation macros

  test "lookup: given a class level :message Message it returns the Message" do
    Model.validates_presence_of :foo, :message => 'message'
    assert_equal 'message', error_on(:foo).to_s
  end

  # given a :message Symbol in class level validation macros

  test "lookup: given a class level :message Symbol it translates the Symbol (message namespace)" do
    store_translations(:'errors.messages.broken' => 'translated')
    Model.validates_presence_of :foo, :message => :broken
    assert_equal 'translated', error_on(:foo).to_s
  end

  test "lookup: given a class level :message Symbol it translates the Symbol (model namespace)" do
    store_translations(:'errors.models.model.broken' => 'translated')
    Model.validates_presence_of :foo, :message => :broken
    assert_equal 'translated', error_on(:foo).to_s
  end

  test "lookup: given a class level :message Symbol it translates the Symbol (attribute namespace)" do
    store_translations(:'errors.models.model.attributes.foo.broken' => 'translated')
    Model.validates_presence_of :foo, :message => :broken
    assert_equal 'translated', error_on(:foo).to_s
  end

  # given a :message Proc returning a Message in class level validation macros

  test "lookup: given a class level :message Proc returning a Message it returns the Message" do
    Model.validates_presence_of :foo, :message => proc { 'message' }
    assert_equal 'message', error_on(:foo).to_s
  end

  # given a :message Proc returning a Symbol in class level validation macros

  test "lookup: given a class level :message Proc returning a Symbol it translates the Symbol (message namespace)" do
    store_translations(:'errors.messages.broken' => 'translated')
    Model.validates_presence_of :foo, :message => proc { :broken }
    assert_equal 'translated', error_on(:foo).to_s
  end

  test "lookup: given a class level :message Proc returning a Symbol it translates the Symbol (model namespace)" do
    store_translations(:'errors.models.model.broken' => 'translated')
    Model.validates_presence_of :foo, :message => proc { :broken }
    assert_equal 'translated', error_on(:foo).to_s
  end

  test "lookup: given a class level :message Proc returning a Symbol it translates the Symbol (attribute namespace)" do
    store_translations(:'errors.models.model.attributes.foo.broken' => 'translated')
    Model.validates_presence_of :foo, :message => proc { :broken }
    assert_equal 'translated', error_on(:foo).to_s
  end
end