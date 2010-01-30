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

    def initialize(subject = nil, options = {})
      @format = options.delete(:format)
      super
    end

    protected

      def resolve(subject, variant = nil)
        format || variant ? formatted(super, variant) : super
      end

      def formatted(subject, variant = nil)
        options = self.options.merge(:message => subject) # TODO :message is ActiveModel::Error specific
        format_class.new(format || variant, options).to_s(variant)
      rescue I18n::String::InvalidStringData, I18n::MissingTranslationData
        subject
      end
  end
end

