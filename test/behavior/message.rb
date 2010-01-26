module Behavior
  module Message
    module Common
      # e.g. validates_presence_of :email, :message => "message"
      test "message is a String, no format key given" do
        assert_equal 'message', message(:blank, 'message').to_s
      end

      test "message is a String, format key :short given" do
        assert_equal 'message', message(:blank, 'message').to_s(:short)
      end

      # e.g. validates_presence_of :email / translations :blank => 'No email?'
      test "no message given, no format key given, translation is a String" do
        store_translations(:blank => 'No email?')
        assert_equal 'No email?', message(:blank).to_s
      end

      test "no message given, format key :short given, translation is a String" do
        store_translations(:blank => 'No email?')
        assert_equal 'No email?', message(:blank).to_s(:short)
      end

      # e.g. validates_presence_of :email, :message => :foo / translations :foo => 'No email?'
      test "message is a Symbol, format key :short given, translation is a String" do
        store_translations(:foo => 'No email?')
        assert_equal 'No email?', message(:blank, :foo).to_s(:short)
      end

      # INTERPOLATION

      test "message given as String, interpolates a variable" do
        assert_equal 'FOO', message(:foo, '%{foo}', :foo => 'FOO').to_s(:short)
      end

      test "message given as String, bogus interpolation variable, does not raise" do
        assert_nothing_raised { message(:foo, 'foo', :foo => 'FOO').to_s(:short) }
      end

      test "no message given, translation is a String, interpolates a variable" do
        store_translations(:foo => '{{foo}}')
        assert_equal 'FOO', message(:foo, nil, :foo => 'FOO').to_s
      end
    end

    module NonFormatted
      # e.g. validates_presence_of :email, :message => "message"
      test "message is a String, format key :full given" do
        assert_equal 'message', message(:blank, 'message').to_s(:full)
      end

      # e.g. validates_presence_of :email / translations :blank => 'No email?'
      test "no message given, format key :full given, translation is a String" do
        store_translations(:blank => 'No email?')
        assert_equal 'No email?', message(:blank).to_s(:full)
      end

      # e.g. validates_presence_of :email, :message => :foo / translations :foo => 'No email?'
      test "message is a Symbol, format key :full given, translation is a String" do
        store_translations(:foo => 'No email?')
        assert_equal 'No email?', message(:blank, :foo).to_s(:full)
      end
    end
  end
end