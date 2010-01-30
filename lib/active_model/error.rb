require 'active_model'
require 'i18n/string'

class ActiveModel::Error < I18n::String
  attr_reader :model, :attribute

  def initialize(message = nil, values = {}, options = {})
    @model, @attribute = values.values_at(:model, :attribute)
    super(message || type, values, options)
  end

  protected

    def scope
      ['errors.messages', super].compact.join('.')
    end
end