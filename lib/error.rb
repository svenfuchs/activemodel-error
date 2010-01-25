require 'message'

class Error < Message
  attr_reader :model, :attribute

  def initialize(type, model, attribute, message = nil, values = {}, options = {})
    @model, @attribute = model, attribute
    values.update(:model => model, :attribute => attribute)
    options.update(:scope => scope)
    super(type, message || type, values, options)
  end

  def to_s(format = :short)
    super(format)
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