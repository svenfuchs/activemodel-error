class I18n::String
  # Sends Strings as defined through the I18n API instead of using them directly.
  #
  module Gettext
    def resolve(message, variant)
      ::String === message ? translate(message, variant) : super
    end
  end
end