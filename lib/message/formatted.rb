class Message
  module Formatted
    def translate(message, variant)
      if variant
        values  = self.values.merge(:message => super)
        options = self.options.merge(:scope => scope)
        Message.new(variant, nil, values, options).to_s
      else
        super
      end
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

