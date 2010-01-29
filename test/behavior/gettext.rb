module Behavior
  module Gettext
    test "Message.new is a String, will be translated" do
      store_translations('Message' => 'The Message.new')
      assert_equal 'The Message.new', message('Message').to_s
    end
  end
end