require 'i18n'
require 'i18n/core_ext/string/interpolate'

class I18n::Message
  autoload :Base,       'i18n/message/base'
  autoload :Cascade,    'i18n/message/cascade'
  autoload :Gettext,    'i18n/message/gettext'
  autoload :Format,     'i18n/message/format'
  autoload :Formatted,  'i18n/message/formatted'
  autoload :Variants,   'i18n/message/variants'
  
  include Base
end