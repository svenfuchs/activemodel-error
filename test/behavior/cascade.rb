module Behavior
  module Cascade
    test "returns message from attribute scope" do
      store_translations(:'models.model.attributes.attribute.message' => 'message')
      assert_equal 'message', message(:message).to_s
    end

    test "returns message from model scope" do
      store_translations(:'models.model.message' => 'message')
      assert_equal 'message', message(:message).to_s
    end

    test "returns message from errors scope" do
      store_translations(:'message' => 'message')
      assert_equal 'message', message(:message).to_s
    end
  end
end