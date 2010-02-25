# encoding: utf-8
require File.expand_path('../../../test_helper', __FILE__)

class ActiveModelApiInterpolationTest < Test::Unit::TestCase
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

  test "interpolates validation data to a translation from the messages namespace" do
    store_translations(:'errors.models.model.too_short' => '%{count}')
    Model.validates_length_of :foo, :minimum => 1
    assert_equal '1', error_on(:foo).to_s
  end

  test "interpolation: given a class level :message Message it interpolates validation data to the Message" do
    Model.validates_length_of :foo, :minimum => 1, :message => '%{count}'
    assert_equal '1', error_on(:foo).to_s
  end

  test "interpolation: given a class level :message Symbol it interpolates validation data to the Symbol's translation" do
    store_translations(:'errors.messages.broken' => '%{count}')
    Model.validates_length_of :foo, :minimum => 1, :message => :broken
    assert_equal '1', error_on(:foo).to_s
  end

  test "interpolation: given a class level :message Proc returning a Message it interpolates validation data to the Message" do
    Model.validates_length_of :foo, :minimum => 1, :message => proc { '%{count}' }
    assert_equal '1', error_on(:foo).to_s
  end

  test "interpolation: given a class level :message Proc returning a Symbol it interpolates validation data to the Symbol's translation" do
    store_translations(:'errors.messages.broken' => '%{count}')
    Model.validates_length_of :foo, :minimum => 1, :message => proc { :broken }
    assert_equal '1', error_on(:foo).to_s
  end

end