class Message
  # Encapsulates the pattern of using a plain String message (as in 
  # validates_presence_of :email, :message => "can't be blank") and 
  # interpolating given values to the resulting string.
  #
  module Base
    attr_reader :type, :message, :values, :options, :scope

    def initialize(type, message = nil, values = {}, options = {})
      @type, @message, @values, @options = type, message, values, options
      @values  ||= {}
      @options ||= {}
    end

    def to_s(variant = nil)
      resolve(message, variant)
    end

    protected

      def resolve(message, variant = nil)
        interpolate(message, variant)
      end

      def interpolate(message, variant = nil)
        message ? message % values : raise(MissingMessageData.new(self))
      end
  end
  
  class MissingMessageData < ArgumentError
    def initialize(message)
      @message = message
    end
  end
end