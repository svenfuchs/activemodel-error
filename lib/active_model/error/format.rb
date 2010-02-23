module ActiveModel
  class Error
    class Format < I18n::String::Format
      protected

        def scope
          :"errors.#{super}"
        end
    end
  end
end