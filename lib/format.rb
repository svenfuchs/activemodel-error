require 'message'

class Format
  include Message::Base
  include Message::Variants
  
  protected

    def scope
      ['formats', super].compact.join('.')
    end
end