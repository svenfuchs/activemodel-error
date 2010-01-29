class Message
  # Encapsulates the pattern of using a plain String message (as in 
  # validates_presence_of :email, :message => "can't be blank") and 
  # interpolating given values to the resulting string.
  #
  module Base
    attr_reader :message, :values, :options, :scope

    def initialize(message = nil, values = {}, options = {})
      @message, @values, @options = message, values, options
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
        message.is_a?(String) ? message % values : raise(InvalidMessageData.new(self))
      end
  end
  
  class InvalidMessageData < ArgumentError
    def initialize(message)
      @message = message
    end
  end
end