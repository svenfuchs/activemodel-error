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
      resolve(subject, variant)
    end

    protected

      def resolve(subject, variant = nil)
        case subject
        when ::String
          interpolate(subject, variant)
        else
          translate(subject, variant)
        end
      end

      def interpolate(subject, variant = nil)
        subject.gsub('{{', '%{') % options # TODO use regex
      end

      INTERPOLATION_SYNTAX_PATTERN = /(\\)?\{\{([^\}]+)\}\}/
      def interpolate(string, variant = nil)
        s = string.gsub(INTERPOLATION_SYNTAX_PATTERN) do
          $1 ? "{{#{$2.to_sym}}}" : "%{#{$2.to_sym}}"
        end
        s % options
      end

      def translate(subject, variant = nil)
        I18n.t(subject, translate_options)
      end

      def translate_options
        { :raise => true, :scope => scope }.merge(options) #.merge(values)
      end
  end
end