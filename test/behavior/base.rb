module Behavior
  module Base
    # e.g. validates_presence_of :email, :message => "message"
    test "message is a String, no format key given" do
      assert_equal 'message', message('message').to_s
    end

    # interpolation
    test "message given as String, interpolates a variable" do
      assert_equal 'FOO', message('%{foo}', :foo => 'FOO').to_s
    end

    test "message given as String, bogus interpolation variable, does not raise" do
      assert_nothing_raised { message('foo', :foo => 'FOO').to_s }
    end
  end
end