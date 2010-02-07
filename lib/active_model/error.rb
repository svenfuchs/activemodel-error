require 'active_model'
require 'i18n/string'

class ActiveModel::Error < I18n::String
  attr_reader :model, :attribute

  def initialize(subject = nil, options = {})
    values = options[:values] || {}
    @model, @attribute = values.values_at(:model, :attribute)
    super(subject || type, options)
  end

  def <=>(other)
    to_s <=> other
  end

  protected

    def scope
      ['errors.messages', super].compact.join('.')
    end

    def translate_options
      scope = self.scope.gsub('.messages', '')
      { :raise => true, :scope => scope, :default => :"messages.#{subject}" }.merge(options)
    end
end