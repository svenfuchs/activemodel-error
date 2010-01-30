module Behavior
  module Gettext
    test "subject is a String, will be translated" do
      store_translations('Message' => 'The Message.new')
      assert_equal 'The Message.new', string('Message').to_s
    end
  end
end