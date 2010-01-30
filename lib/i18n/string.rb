require 'i18n'
require 'i18n/core_ext/string/interpolate'

class I18n::String
  autoload :Base,       'i18n/string/base'
  autoload :Cascade,    'i18n/string/cascade'
  autoload :Gettext,    'i18n/string/gettext'
  autoload :Format,     'i18n/string/format'
  autoload :Formatted,  'i18n/string/formatted'
  autoload :Variants,   'i18n/string/variants'
  
  include Base
end