class Message
  module Cascade
    def options
      super.merge(:cascade => { :step => 2, :skip_root => true })
    end
  end
end