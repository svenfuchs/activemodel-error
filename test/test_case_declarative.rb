module Declarative
  def self.included(base)
    base.class_eval do
      def test(name, &block)
        name    = "test_#{name.gsub(/\s+/,'_')}".to_sym
        block ||= lambda { flunk "No implementation provided for #{name}" }

        defined = instance_method(name) rescue false
        raise("#{name} is already defined in #{self}") if defined

        define_method(name, &block)
      end
    end
  end
end

class Test::Unit::TestCase
  include Declarative
end

class Module
  include Declarative
end
