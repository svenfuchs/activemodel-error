require 'active_support/core_ext/class/attribute_accessors'

class Message
  # Encapsulates the pattern of wrapping a message with a format string.
  #
  module Formatted
    def self.included(base)
      base.class_eval do
        cattr_accessor :format_class
        self.format_class = Format
      end
    end
    
    attr_reader :format

    def initialize(message = nil, values = {}, options = {})
      @format = options.delete(:format)
      super
    end

    def resolve(message, variant = nil)
      format || variant ? formatted(super, variant) : super
    end

    def formatted(message, variant = nil)
      values = self.values.merge(:message => message)
      format_class.new(format || variant, values, options).to_s(variant)
    rescue ArgumentError
      message # rescues Message::MissingMessageData and I18n::MissingTranslationData
    end
  end
end

