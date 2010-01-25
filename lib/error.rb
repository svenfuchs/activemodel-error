require 'message'

class Error < Message
  attr_reader :model, :attribute

  def initialize(type, message = nil, values = {}, options = {})
    @model, @attribute = values.values_at(:model, :attribute)
    super(type, message || type, values, options.merge(:scope => scope))
  end

  def to_s(variant = :short)
    super
  end

  protected

    def scope
      if self.class.included_modules.include?(Cascade)
        :"errors.messages.models.#{model.downcase}.attributes.#{attribute}"
      else
        :"errors.messages"
      end
    end
end