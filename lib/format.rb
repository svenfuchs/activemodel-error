require 'message'

class Format
  include Message::Base
  
  protected

    def scope
      ['formats', super].compact.join('.')
    end
end