require 'active_model'
require 'i18n/string'

class ActiveModel::Error < I18n::String
  attr_reader :model, :attribute

  def initialize(subject = nil, options = {})
    values = options[:values] || {}
    @model, @attribute = values.values_at(:model, :attribute)
    super(subject || type, options)
  end

  protected

    def scope
      ['errors.messages', super].compact.join('.')
    end
end