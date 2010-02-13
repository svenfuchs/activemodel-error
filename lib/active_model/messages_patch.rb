require 'active_support/core_ext/class/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'active_model'

module ActiveModel
  autoload :Error, 'active_model/error'

  # Error.send(:include, I18n::String::Variants, I18n::String::Formatted)

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

  class AttributeErrors
    include Enumerable

    attr_accessor :attribute, :errors
    delegate :size, :empty?, :first, :second, :last, :to => :errors

    def initialize(base, attribute)
      @base = base
      @attribute = attribute
      @errors = []
    end

    def add(message = nil, options = {})
      message = generate_message(message, options) if message.is_a?(Symbol)
      @errors << message
    end

    alias :<< :add

    def each
      @errors.each { |error| yield error }
    end

    def include?(message)
      if message.is_a?(Symbol)
        @errors.any? { |error| error.subject == message }
      elsif message.is_a?(String)
        @errors.any? { |error| error.to_s == message }
      else
        @errors.include?(message)
      end
    end

    def generate_message(type = :invalid, options = {})
      @base.generate_message(attribute, type, options)
    end

    def to_a
      @errors
    end
  end
end