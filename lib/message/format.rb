class Message
  class Format
    include Base
  
    protected

      def scope
        ['formats', super].compact.join('.')
      end
  end
end