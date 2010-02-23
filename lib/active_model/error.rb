require 'active_model'
require 'i18n/string'

class ActiveModel::Error < I18n::String
  autoload :Base,   'active_model/error/base'
  autoload :Legacy, 'active_model/error/legacy'
  
  include Base
  include Legacy
  include Variants, Formatted
end