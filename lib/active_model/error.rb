require 'active_model'
require 'i18n/message'

module ActiveModel
  class Error < I18n::Message
    autoload :Base,   'active_model/error/base'
    autoload :Format, 'active_model/error/format'
    autoload :Legacy, 'active_model/error/legacy'

    include Base, Formatted, Variants, Legacy

    self.format_class = ActiveModel::Error::Format
  end
end