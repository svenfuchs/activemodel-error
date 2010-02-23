module ActiveModel
  class Error < I18n::String
    module Base
      attr_reader :base, :attribute, :value

      def initialize(subject = nil, options = {})
        @base, @attribute, @value = options.values_at(:model, :attribute, :value)
        @attribute = attribute
        super(subject, options)
      end
    end
  end
end