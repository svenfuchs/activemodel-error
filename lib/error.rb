require 'message'

class Error < Message
  attr_reader :model, :attribute

  def initialize(type, model, attribute, message = nil, values = {}, options = {})
    @model, @attribute = model, attribute
    super(type, message || type, values, options)
  end

  def to_s(format = :short)
    super(format)
  end

  protected

    def values
      super.merge(:model => model, :attribute => attribute)
    end

    def options
      super.merge(:scope => scope)
    end

    def scope
      if self.class.included_modules.include?(Cascade)
        [:errors, :messages, :models, model.downcase, :attributes, attribute]
      else
        [:errors, :messages]
      end
    end
end