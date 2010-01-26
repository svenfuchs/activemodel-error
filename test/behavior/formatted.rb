module Behavior
  module Formatted
    test "uses a full message format to wrap a short message" do
      store_translations(:'blank' => 'blank')
      assert_equal "full blank", message(:blank, nil).to_s(:full)
    end
  end
end