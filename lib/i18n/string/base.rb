class I18n::String
  # Encapsulates the patterns of:
  #
  #   * using a plain String (as in validates_presence_of :email, :message => "can't be blank")
  #   * translating a Symbol (as in validates_presence_of :email, :message => :blank)
  #   * interpolating given values to the resulting string.
  #
  module Base
    attr_reader :subject, :options, :scope

    attr_reader :subject, :scope, :default, :values

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

      def resolve(subject)
        case subject
        when Proc
          resolve(subject.call)
        when ::String
          interpolate(subject)
        else
          translate(subject, translate_options(subject))
        end
      end

      INTERPOLATION_SYNTAX_PATTERN = /(\\)?\{\{([^\}]+)\}\}/
      def interpolate(subject)
        s = subject.gsub(INTERPOLATION_SYNTAX_PATTERN) do
          $1 ? "{{#{$2.to_sym}}}" : "%{#{$2.to_sym}}"
        end
        s % options
      end

      def translate(subject, options)
        I18n.t(subject, options.dup)
      end

      def translate_options(subject)
        { :scope => scope, :raise => true }.merge(options)
      end
  end
end