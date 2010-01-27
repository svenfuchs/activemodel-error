require 'active_support/core_ext/class/attribute_accessors'

class Message
  # Encapsulates the pattern of looking a translated message up from several
  # scopes.
  #
  module Cascade
    def self.included(base)
      base.class_eval do
        cattr_accessor :cascade_options
        self.cascade_options = { :step => 2, :skip_root => true }
      end
    end

    def options
      super.update(:cascade => self.class.cascade_options)
    end
    
    def scope
      scopes = self.class.cascade_options[:scopes]
      scopes = [super] + scopes.map { |scope| "#{scope}s.#{values[scope].to_s.underscore}" if values[scope] }
      scopes.compact.join('.')
    end
  end
end