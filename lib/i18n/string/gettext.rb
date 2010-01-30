class I18n::String
  # Sends message Strings as defined in class-level definitions through the
  # I18n API instead of returning them.
  #
  module Gettext
    def resolve(message, variant)
      ::String === message ? translate(message, variant) : super
    end
  end
end