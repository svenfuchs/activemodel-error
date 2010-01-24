require 'i18n'
require 'i18n/core_ext/string/interpolate'

# add a module for gettext-style class level messages, i.e. resolve string 
# messages by translating them

class Message
  autoload :Cascade,  'message/cascade'
  autoload :Gettext,  'message/gettext'
  autoload :Variants, 'message/variants'

  attr_reader :type, :message, :values, :options

  def initialize(type, message = {}, values = {}, options = {})
    @type, @message, @values, @options = type, message, values, options
  end

  def to_s(variant = nil)
    message = message_for(variant)
    resolve(message, variant)
  end

  protected

    def message_for(variant)
      message
    end

    def resolve(message, variant)
      case message
      when String
        interpolate(message)
      when Symbol
        translate(message, variant)
      else
        translate(type, variant)
      end
    end

    def interpolate(message)
      message % values
    end

    def translate(message, variant)
      I18n.t(message, translate_options)
    end
  
    def translate_options
      @translate_options ||= { :raise => true }.merge(self.options).merge(values)
    end
end