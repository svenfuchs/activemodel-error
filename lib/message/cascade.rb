class Message
  module Cascade
    class << self
      def included(base)
        base.extend(ClassMethods)
      end
    end

    def initialize(type, message = nil, values = {}, options = {})
      options.update(:cascade => self.class.cascade_options)
      super
    end

    module ClassMethods
      def cascade_options=(options)
        @@cascade_options = options # should probably be a class inheritable accessor
      end

      def cascade_options
        @@cascade_options ||= { :step => 2, :skip_root => true }
      end
    end
  end
end