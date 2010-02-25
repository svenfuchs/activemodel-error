module Behavior
  module Formatted
    test "subject Message given, format Message given" do
      assert_equal 'formatted message', message('message', :format => 'formatted %{message}').to_s
    end

    test "subject Message given, format Hash given" do
      assert_equal 'formatted message', message('message', :format => { :full => 'formatted %{message}' }).to_s(:full)
    end

    test "uses a format to wrap a translated message" do
      store_translations(:blank => 'blank')
      assert_equal "formatted blank", message(:blank, :format => 'formatted %{message}').to_s
    end

    test "uses a translated format to wrap a message" do
      store_translations(:blank => 'blank', :'formats.full' => 'full %{message}')
      assert_equal "full blank", message(:blank).to_s(:full)
    end
  end
end