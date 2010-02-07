require 'active_model'
require 'i18n/string'

class ActiveModel::Error < I18n::String
  attr_reader :base, :model, :attribute

  def initialize(subject = nil, options = {})
    @base, @attribute = options.values_at(:model, :attribute)
    @model = options[:model] = @base.class.model_name
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