require 'message'

class Format
  include Message::Base
  include Message::Variants
  
  def scope
    ['formats', super].compact.join('.')
  end
end