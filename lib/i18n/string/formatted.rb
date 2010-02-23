require 'active_support/core_ext/class/attribute_accessors'

class I18n::String
  # Encapsulates the pattern of wrapping a string with a format string.
  #
  module Formatted
    def self.included(base)
      base.class_eval do
        class << self
          def format_class
            @format_class ||= Format
          end

          def format_class=(format_class)
            @format_class = format_class
          end
        end
      end
    end

    attr_reader :format

    def initialize(subject = nil, options = {})
      @format = options.delete(:format)
      super
    end

    def to_s(variant = nil)
      formatted(super(variant || :short), variant || :default)
    end

    protected

      def formatted(subject, variant = nil)
        options = self.options.merge(:message => subject) # TODO :message is ActiveModel::Error specific, isn't it?
        self.class.format_class.new(format || variant, options).to_s(variant)
      rescue I18n::MissingTranslationData
        subject
      end
  end
end

