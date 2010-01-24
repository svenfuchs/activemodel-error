require 'i18n'
require 'i18n/core_ext/string/interpolate'

class Message
  class << self
    def cascade
      @@cascade ||= false
    end

    def cascade=(cascade)
      @@cascade = cascade
    end
  end

  attr_reader :type, :message, :options

  def initialize(type, message = {}, options = {})
    @type    = type
    @message = message
    @options = { :raise => true }.merge(options)
    @values.update(:cascade => true) if self.class.cascade
  end
  
  def to_s(format = :short, values = {})
    message = lookup(format)
    case message
    when String
      # could add a :translate_strings option here to support gettext-style class-method calls
      interpolate(message, values) 
    when Symbol
      translate(message, format, values)
    else
      translate(type, format, values)
    end
  rescue I18n::MissingTranslationData => e
    format != :short ? to_s(:short, values) : raise(e)
  end
  
  def method_missing(method)
    to_s(method)
  end
  
  protected
  
    def lookup(format)
      case message
      when String, Symbol; message
      when Hash;           message[format]
      end
    end

    def interpolate(message, values)
      message % values
    end

    def translate(message, format, values)
      options = self.options.merge(:default => [:"#{message}.short", message])
      I18n.t(:"#{message}.#{format}", options.merge(values))
    end
end