class Message
  module Variants
    def message_for(variant)
      Hash === message ? message[variant] : super
    end

    def translate(message, variant)
      I18n.t(:"#{message}.#{variant}", translate_options)
    rescue I18n::MissingTranslationData => e
      result = super
      result.is_a?(String) ? result : raise(e)
    end
  end
end