require 'message'

class Error < Message
  attr_reader :model, :attribute

  def initialize(type, message = nil, values = {}, options = {})
    @model, @attribute = values.values_at(:model, :attribute)
    super(type, message || type, values, options)
  end

  def to_s(variant = :short)
    super
  end

  protected

    def scope
      ['errors', super].compact.join('.')
    end
end