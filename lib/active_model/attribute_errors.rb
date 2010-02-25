module ActiveModel
  class AttributeErrors
    include Enumerable

    attr_accessor :attribute, :errors
    delegate :size, :empty?, :first, :second, :last, :to => :errors

    def initialize(base, attribute)
      @base = base
      @attribute = attribute
      @errors = []
    end

    def add(message = nil, options = {})
      message = generate_message(message, options) if message.is_a?(Symbol)
      @errors << message
    end

    alias :<< :add

    def each
      @errors.each { |error| yield error }
    end

    def include?(message)
      case message
      when Symbol
        @errors.any? { |error| error.subject == message }
      when String
        @errors.any? { |error| error.to_s == message }
      else
        @errors.include?(message)
      end
    end

    def generate_message(type = :invalid, options = {})
      @base.generate_message(attribute, type, options)
    end

    def to_a
      @errors
    end
  end
end