class I18n::String
  # Encapsulates the pattern of strings having multiple variations as :short
  # message, :full message etc.
  #
  module Variants
    attr_reader :variant

    def to_s(variant = nil)
      @variant = variant
      resolve(Hash === subject ? subject[variant || :short] : subject)
    end

    protected

      def translate(subject, options)
        super(:"#{subject}.#{variant || :short}", variant_translate_options(options))
      rescue I18n::MissingTranslationData => e
        super(subject, options).tap { |result| raise(e) unless result.is_a?(String) }
      end

      # uuuuuuurghs.
      def variant_translate_options(options)
        options[:default].map! { |key| :"#{key}.#{variant || :short}" } if options[:default].is_a?(Array)
        options
      end
  end
end
