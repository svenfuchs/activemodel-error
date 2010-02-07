require 'active_model'
require 'i18n/string'

class ActiveModel::Error < I18n::String
  attr_reader :base, :attribute, :value

  def initialize(subject = nil, options = {})
    @base, @attribute, @value = options.values_at(:model, :attribute, :value)
    @attribute = attribute
    super(subject || type, options)
  end

  def <=>(other)
    to_s <=> other
  end

  protected

    def translate(subject, variant = nil)
      defaults = base.class.lookup_ancestors.map do |klass|
        [ :"models.#{klass.name.underscore}.attributes.#{attribute}.#{subject}",
          :"models.#{klass.name.underscore}.#{subject}" ]
      end

      defaults << options.delete(:default)
      defaults = defaults.compact.flatten << :"messages.#{subject}"

      key = defaults.shift
      options = @options.merge(
        :scope     => :errors,
        :default   => defaults,
        :model     => base.class.model_name.human,
        :attribute => base.class.human_attribute_name(attribute),
        :value     => value,
        :raise     => true
      )

      I18n.translate(key, options)
    end
end