module Behavior
  module Translated
    # e.g. validates_presence_of :email / translations :blank => 'No email?'
    test "no message given, no format key given, translation is a String" do
      store_translations(:'messages.blank' => 'No email?')
      assert_equal 'No email?', message(:blank).to_s
    end

    test "no message given, format key :short given, translation is a String" do
      store_translations(:'messages.blank' => 'No email?')
      assert_equal 'No email?', message(:blank).to_s
    end

    # e.g. validates_presence_of :email, :message => :foo / translations :foo => 'No email?'
    test "message is a Symbol, format key :short given, translation is a String" do
      store_translations(:'messages.foo' => 'No email?')
      assert_equal 'No email?', message(:blank, :foo).to_s
    end

    # INTERPOLATION
    test "no message given, translation is a String, interpolates a variable" do
      store_translations(:'messages.foo' => '{{foo}}')
      assert_equal 'FOO', message(:foo, nil, :foo => 'FOO').to_s
    end
  end
end