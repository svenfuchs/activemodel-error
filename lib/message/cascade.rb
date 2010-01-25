class Message
  module Cascade
    def options
      super.merge(:cascade => self.class.const_get(:CASCADE_OPTIONS))
    end
  end
end