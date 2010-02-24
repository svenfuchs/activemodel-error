module Behavior
  module Base
    # NOT TRANSLATED

    # e.g. validates_presence_of :email, :message => "message"
    test "subject is a String, no format key given" do
      assert_equal 'message', string('message').to_s
    end

    test "subject evaluates to a String, no format key given" do
      assert_equal 'message', string(Proc.new {'message'}).to_s
    end

    # interpolation
    test "subject is a String, interpolates a variable" do
      assert_equal 'FOO', string('%{foo}', :foo => 'FOO').to_s
    end

    test "subject evaluates to a String, interpolates a variable" do
      assert_equal 'FOO', string(Proc.new {'%{foo}'}, :foo => 'FOO').to_s
    end

    test "subject is a String, bogus interpolation variable, does not raise" do
      assert_nothing_raised { string('foo', :foo => 'FOO').to_s }
    end

    test "subject evaluates to a String, bogus interpolation variable, does not raise" do
      assert_nothing_raised { string(Proc.new {'foo'}, :foo => 'FOO').to_s }
    end


    # TRANSLATED

    # e.g. validates_presence_of :email / translations :blank => 'No email?'
    test "subject is a Symbol, no format key given, translation is a String" do
      store_translations(:blank => 'No email?')
      assert_equal 'No email?', string(:blank).to_s
    end

    test "subject is a Symbol, format key :short given, translation is a String" do
      store_translations(:blank => 'No email?')
      assert_equal 'No email?', string(:blank).to_s(:short)
    end

    test "subject is a Symbol, format key :full given, translation is a String" do
      store_translations(:blank => 'No email?')
      assert_equal 'No email?', string(:blank).to_s(:full)
    end

    # INTERPOLATION
    test "subject is a Symbol, translation is a String, interpolates a variable" do
      store_translations(:foo => '{{foo}}')
      assert_equal 'FOO', string(:foo, :foo => 'FOO').to_s
    end

    test "subject evaluates to a Symbol, translation is a String, interpolates a variable" do
      store_translations(:foo => '{{foo}}')
      assert_equal 'FOO', string(Proc.new { :foo }, :foo => 'FOO').to_s
    end

  end
end