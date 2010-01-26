class Message
  module Formatted
    # TODO no tests breaks when this method is removed
    def interpolate(message, variant)
      message = super
      variant ? format(message, variant) : message
    end

    def translate(message, variant)
      message = super
      variant ? format(message, variant) : message
    end
    
    def format(message, variant)
      values  = self.values.merge(:message => super)
      options = self.options.merge(:scope => scope)
      Message.new(variant, nil, values, options).to_s
    end

    def scope
      if self.class.included_modules.include?(Cascade)
        :"errors.formats.models.#{model.downcase}.attributes.#{attribute}"
      else
        :'errors.formats'
      end
    end
  end
end

