require 'message'

class Error < Message
  attr_reader :type, :values
  
  def initialize(type, model, attribute, message = nil, options = {})
    super(type, message || type, options)
    @values = { :model => model, :attribute => attribute, :scope => [:errors, model.downcase, attribute] }
  end

  def to_s(format = :short, values = {})
    super(format, self.values.merge(values))
  end
end
