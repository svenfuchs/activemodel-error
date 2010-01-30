class I18n::String
  # Encapsulates the pattern of strings having multiple variations as :short
  # message, :full message etc.
  #
  module Variants
    def to_s(variant = :short)
      resolve(pick(variant), variant)
    end

    protected

      def pick(variant)
        Hash === subject ? subject[variant] : subject
      end

      def translate(subject, variant)
        I18n.t(:"#{subject}.#{variant}", translate_options)
      rescue I18n::MissingTranslationData => e
        result = super
        result.is_a?(::String) ? result : raise(e)
      end
  end
end
