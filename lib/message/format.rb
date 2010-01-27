class Message
  class Format
    include Base
    include Variants
    
    def scope
      ['formats', super].compact.join('.')
    end
  end
end