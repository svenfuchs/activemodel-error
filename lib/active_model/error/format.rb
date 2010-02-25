module ActiveModel
  class Error
    class Format < I18n::Message::Format
      protected

        def scope
          :"errors.#{super}"
        end
    end
  end
end