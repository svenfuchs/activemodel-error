class Message
  module Gettext
    def resolve(message, variant)
      String === message ? translate(message, variant) : super
    end
  end
end