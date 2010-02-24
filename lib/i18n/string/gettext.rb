class I18n::String
  # Sends Strings as defined through the I18n API instead of using them directly.
  #
  module Gettext
    protected

      def resolve(*args)
        ::String === args.first ? translate(*args) : super
      end
  end
end