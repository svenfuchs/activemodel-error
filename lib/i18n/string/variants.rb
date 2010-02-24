class I18n::String
  # Encapsulates the pattern of strings having multiple variations as :short
  # message, :full message etc.
  #
  module Variants
    def to_s(variant = :short)
      resolve(Hash === subject ? subject[variant] : subject, variant)
    end

    protected

      def translate(*args)
        subject, variant = *args
        super(subject, variant, variant_translate_options(subject, variant))
      rescue I18n::MissingTranslationData => e
        super(subject).tap { |result| raise(e) unless result.is_a?(String) }
      end
      
      # uuuuuuurghs.
      def variant_translate_options(*args)
        subject, variant = *args
        translate_options(subject, variant).tap do |options|
          options[:default].map! { |key| :"#{key}.#{variant}" } if options[:default].is_a?(Array)
        end
      end
  end
end
