module Behavior
  module Formatted
    test "subject String given, format String given" do
      assert_equal 'formatted message', string('message', :format => 'formatted %{message}').to_s
    end

    test "subject String given, format Hash given" do
      assert_equal 'formatted message', string('message', :format => { :full => 'formatted %{message}' }).to_s(:full)
    end

    test "uses a format to wrap a translated message" do
      store_translations(:blank => 'blank')
      assert_equal "formatted blank", string(:blank, :format => 'formatted %{message}').to_s
    end

    test "uses a translated format to wrap a message" do
      store_translations(:blank => 'blank', :'formats.full' => 'full %{message}')
      assert_equal "full blank", string(:blank).to_s(:full)
    end
  end
end