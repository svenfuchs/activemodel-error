require 'i18n'
require 'i18n/core_ext/string/interpolate'

class Message
  autoload :Base,       'message/base'
  autoload :Cascade,    'message/cascade'
  autoload :Gettext,    'message/gettext'
  autoload :Formatted,  'message/formatted'
  autoload :Translated, 'message/translated'
  autoload :Variants,   'message/variants'
  
  include Base
  include Translated
  
  protected

    def scope
      ['messages', super].compact.join('.')
    end
end