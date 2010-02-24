class I18n::String
  # Encapsulates the patterns of:
  #
  #   * using a plain String (as in validates_presence_of :email, :message => "can't be blank")
  #   * translating a Symbol (as in validates_presence_of :email, :message => :blank)
  #   * interpolating given values to the resulting string.
  #
  module Base
    attr_reader :subject, :options, :scope

    def initialize(subject = nil, options = {})
      @subject, @options = subject, options
      @options ||= {}
    end

    def to_s(variant = nil)
      resolve(subject)
    end

    def <=>(other)
      to_s <=> other
    end
    
    protected

      def resolve(*args)
        case args.first
        when Proc
          resolve(args.shift.call, *args)
        when ::String
          interpolate(*args)
        else
          translate(*args)
        end
      end

      INTERPOLATION_SYNTAX_PATTERN = /(\\)?\{\{([^\}]+)\}\}/
      def interpolate(*args)
        s = args.first.gsub(INTERPOLATION_SYNTAX_PATTERN) do
          $1 ? "{{#{$2.to_sym}}}" : "%{#{$2.to_sym}}"
        end
        s % options
      end

      def translate(*args)
        options = args.last.is_a?(Hash) ? args.pop : translate_options(args.first)
        key = options[:default].is_a?(Array) ? options[:default].shift : args.first
        I18n.t(key, options)
      end

      def translate_options(*args)
        { :default => [args.first], :raise => true, :scope => scope }.merge(options)
      end
  end
end