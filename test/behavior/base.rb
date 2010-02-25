module Behavior
  module Base
    # NOT TRANSLATED

    # e.g. validates_presence_of :email, :message => "message"
    test "subject is a Message, no format key given" do
      assert_equal 'message', message('message').to_s
    end

    test "subject evaluates to a Message, no format key given" do
      assert_equal 'message', message(Proc.new {'message'}).to_s
    end

    # interpolation
    test "subject is a Message, interpolates a variable" do
      assert_equal 'FOO', message('%{foo}', :foo => 'FOO').to_s
    end

    test "subject evaluates to a Message, interpolates a variable" do
      assert_equal 'FOO', message(Proc.new {'%{foo}'}, :foo => 'FOO').to_s
    end

    test "subject is a Message, bogus interpolation variable, does not raise" do
      assert_nothing_raised { message('foo', :foo => 'FOO').to_s }
    end

    test "subject evaluates to a Message, bogus interpolation variable, does not raise" do
      assert_nothing_raised { message(Proc.new {'foo'}, :foo => 'FOO').to_s }
    end

    # TRANSLATED

    # e.g. validates_presence_of :email / translations :blank => 'No email?'
    test "subject is a Symbol, no format key given, translation is a Message" do
      store_translations(:blank => 'No email?')
      assert_equal 'No email?', message(:blank).to_s
    end

    # INTERPOLATION
    test "subject is a Symbol, translation is a Message, interpolates a variable" do
      store_translations(:foo => '{{foo}}')
      assert_equal 'FOO', message(:foo, :foo => 'FOO').to_s
    end

    test "subject evaluates to a Symbol, translation is a Message, interpolates a variable" do
      store_translations(:foo => '{{foo}}')
      assert_equal 'FOO', message(Proc.new { :foo }, :foo => 'FOO').to_s
    end

  end
end