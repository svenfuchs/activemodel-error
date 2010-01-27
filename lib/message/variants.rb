class Message
  # Encapsulates the pattern of messages having multiple variations as :short
  # message, :full message etc.
  #
  module Variants
    def to_s(variant = nil)
      resolve(message_for(variant), variant)
    end
    
    def message_for(variant)
      Hash === message ? message[variant] : message
    end

    def translate(message, variant)
      I18n.t(:"#{message}.#{variant}", translate_options)
    rescue I18n::MissingTranslationData => e
      result = super
      result.is_a?(String) ? result : raise(e)
    end
  end
end
