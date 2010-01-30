require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/inflector'
require 'active_support/core_ext/string/inflections'

class I18n::String
  # Encapsulates the pattern of looking up a translation key from several
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
      scopes = [super] + scopes.map { |scope| "#{scope}s.#{options[scope].to_s.underscore}" if options[scope] }
      scopes.compact.join('.')
    end
  end
end