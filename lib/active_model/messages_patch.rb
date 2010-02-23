require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'active_model'

module ActiveModel
  autoload :Error, 'active_model/error'
  autoload :AttributeErrors, 'active_model/attribute_errors'

  class Errors
    cattr_accessor :error_class
    @@error_class = ActiveModel::Error

    def [](attribute)
      if errors = get(attribute.to_sym)
        errors
      else
        set(attribute.to_sym, AttributeErrors.new(self, attribute.to_sym))
      end
    end

    def add(attribute, message = nil, options = {})
      self[attribute].add(message, options)
    end

    def generate_message(attribute, type = :invalid, options = {})
      options.update(:model => @base, :attribute => attribute)
      error_class.new(options.delete(:default) || type, options)
    end
  end
end