# # encoding: utf-8
# require File.expand_path(File.dirname(__FILE__)) + '/test_helper'
# require 'error'
#
# class ValidationTest < Test::Unit::TestCase
#   class Model
#     class << self
#       def name; 'Model'; end
#       def validates_foo(attribute, options = {})
#         @@errors = [Error.new(:foo, self.name, attribute, options[:message])]
#       end
#     end
#     def errors; @@errors end
#   end
#
#   test "message given as String, :short format" do
#     Model.validates_foo :bar, :message => 'broken'
#     assert_equal ['broken'], Model.new.errors.map(&:to_s)
#   end
#
#   test "message given as Hash, :short format" do
#     Model.validates_foo :bar, :message => { :short => 'broken', :full => 'really kaputt'}
#     assert_equal ['broken'], Model.new.errors.map(&:to_s)
#   end
#
#   test "message given as Hash, :full format" do
#     Model.validates_foo :bar, :message => { :short => 'broken', :full => 'really kaputt'}
#     assert_equal ['really kaputt'], Model.new.errors.map(&:full)
#   end
#
#   test "no message given, i18n has a String, :short format" do
#     Model.validates_foo :bar
#     store_translations(:foo => 'snafu!')
#     assert_equal ['snafu!'], Model.new.errors.map(&:to_s)
#   end
#
#   test "no message given, i18n has a Hash, :short format" do
#     Model.validates_foo :bar
#     store_translations(:foo => { :short => 'broken', :full => 'really kaputt'})
#     assert_equal ['broken'], Model.new.errors.map(&:to_s)
#   end
#
#   test "no message given, i18n has a Hash, :full format" do
#     Model.validates_foo :bar
#     store_translations(:foo => { :short => 'broken', :full => 'really kaputt'})
#     assert_equal ['really kaputt'], Model.new.errors.map(&:full)
#   end
#
#   test "interpolation" do
#     Model.validates_foo :bar, :message => '%{model} %{attribute} is broken'
#     assert_equal ['ValidationTest::Model bar is broken'], Model.new.errors.map(&:to_s)
#   end
#
#   def store_translations(errors)
#     I18n.backend.store_translations(:en, :errors => { :messages => errors })
#   end
# end