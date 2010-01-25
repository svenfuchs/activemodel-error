class Message
  module Base
    attr_reader :type, :message, :values, :options

    def initialize(type, message = nil, values = {}, options = {})
      @type, @message, @values, @options = type, message, values, options
    end

    def to_s(variant = nil)
      resolve(message_for(variant), variant)
    end

    protected

      def message_for(variant)
        message
      end

      def resolve(message, variant)
        case message
        when String
          interpolate(message)
        when Symbol
          translate(message, variant)
        else
          translate(type, variant)
        end
      end

      def interpolate(message)
        message % values
      end

      def translate(message, variant)
        I18n.t(message, translate_options)
      end
  
      def translate_options
        @translate_options ||= { :raise => true }.merge(options).merge(values)
      end
  end
end