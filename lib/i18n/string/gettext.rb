class I18n::String
  # Sends Strings as defined through the I18n API instead of using them directly.
  #
  module Gettext
    protected

      def resolve(subject)
        ::String === subject ? translate(subject, translate_options(subject)) : super
      end
  end
end