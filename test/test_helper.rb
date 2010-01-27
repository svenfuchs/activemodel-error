$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
$:.unshift(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'test/unit'
require 'behavior'

require 'message'
require 'format'

module TestMethod
  def self.included(base)
    base.class_eval do
      def test(name, &block)
        test_name = "test_#{name.gsub(/\s+/,'_')}".to_sym
        defined = instance_method(test_name) rescue false
        raise "#{test_name} is already defined in #{self}" if defined
        if block_given?
          define_method(test_name, &block)
        else
          define_method(test_name) do
            flunk "No implementation provided for #{name}"
          end
        end
      end
    end
  end
end

class Module
  include TestMethod
end

class Test::Unit::TestCase
  include TestMethod

  def teardown
    I18n.backend  = nil
  end
  
  def message(*args)
    self.class.const_get(:Message).new(*args)
  end

  def store_translations(data)
    I18n.backend.store_translations(:en, data)
  end
end

class CascadingBackend < I18n::Backend::Simple
  include I18n::Backend::Cascade
end
