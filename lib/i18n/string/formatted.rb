require 'active_support/core_ext/class/attribute_accessors'

class I18n::String
  # Encapsulates the pattern of wrapping a string with a format string.
  #
  module Formatted
    def self.included(base)
      base.class_eval do
        cattr_accessor :format_class
        self.format_class = Format
      end
    end
    
    attr_reader :format

    def initialize(subject = nil, values = {}, options = {})
      @format = options.delete(:format)
      super
    end

    def resolve(subject, variant = nil)
      format || variant ? formatted(super, variant) : super
    end

    def formatted(subject, variant = nil)
      values = self.values.merge(:message => subject) # TODO :message is Error specific
      format_class.new(format || variant, values, options).to_s(variant)
    rescue ArgumentError
      subject # rescues I18n::String::InvalidStringData and I18n::MissingTranslationData
    end
  end
end

