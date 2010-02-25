# encoding: utf-8
require File.expand_path('../../test_helper', __FILE__)

class ActiveModelApiFormatTest < Test::Unit::TestCase
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

  # FIXME this currently can't be supported because rails does not pass the
  # format option through
  #
  # test "uses a format given at class level to format a message" do
  #   Model.validates_presence_of :foo, :message => 'message', :format => 'formatted %{message}'
  #   assert_equal "formatted message", error_on(:foo).to_s
  # end

  test "uses a format stored as a translation to wrap a message (messages namespace)" do
    Model.validates_presence_of :foo, :message => 'message'
    store_translations(:'errors.formats.default' => 'formatted %{message}')
    assert_equal "formatted message", error_on(:foo).to_s
  end

  # FIXME currently not supported and probably should be optional
  #
  # test "uses a format stored as a translation to wrap a message (models namespace)" do
  #   Model.validates_presence_of :foo, :message => 'message'
  #   store_translations(:'errors.formats.models.model.default' => 'formatted %{message}')
  #   assert_equal "formatted message", error_on(:foo).to_s
  # end
  # 
  # test "uses a format stored as a translation to wrap a message (attributes namespace)" do
  #   Model.validates_presence_of :foo, :message => 'message'
  #   store_translations(:'errors.formats.models.model.attributes.foo.default' => 'formatted %{message}')
  #   assert_equal "formatted message", error_on(:foo).to_s
  # end

  test "uses a format stored as a translation to wrap a message variant (messages namespace)" do
    Model.validates_presence_of :foo, :message => 'message'
    store_translations(:'errors.formats.full' => 'full %{message}')
    assert_equal "full message", error_on(:foo).to_s(:full)
  end

  # FIXME currently not supported and probably should be optional
  #
  # test "uses a format stored as a translation to wrap a message variant (models namespace)" do
  #   Model.validates_presence_of :foo, :message => 'message'
  #   store_translations(:'errors.formats.models.model.default' => 'formatted %{message}')
  #   assert_equal "formatted message", error_on(:foo).to_s
  # end
  # 
  # test "uses a format stored as a translation to wrap a message variant (attributes namespace)" do
  #   Model.validates_presence_of :foo, :message => 'message'
  #   store_translations(:'errors.formats.models.model.attributes.foo.default' => 'formatted %{message}')
  #   assert_equal "formatted message", error_on(:foo).to_s
  # end

end