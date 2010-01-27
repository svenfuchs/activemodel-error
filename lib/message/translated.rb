class Message
  # Encapsulates the pattern of translating a message if it's a Symbol (as in 
  # validates_presence_of :email, :message => :blank) or alternatively using
  # the message type as a translation key (as in validates_presence_of :email)
  #
  module Translated
    protected

      def resolve(message, variant = nil)
        case message
        when String
          super
        when Symbol
          translate(message, variant)
        else
          translate(type, variant)
        end
      end

      def translate(message, variant = nil)
        I18n.t(message, translate_options)
      end
  
      def translate_options
        @translate_options ||= { :raise => true, :scope => scope }.merge(options).merge(values)
      end
  end
end