module Behavior
  module Cascade
    test "returns message from attribute scope" do
      store_translations(:'messages.models.model.attributes.attribute.message' => 'message')
      assert_equal 'message', message(:message, :model => 'model', :attribute => 'attribute').to_s
    end

    test "returns message from model scope" do
      store_translations(:'messages.models.model.message' => 'message')
      assert_equal 'message', message(:message, :model => 'model', :attribute => 'attribute').to_s
    end

    test "returns message from errors scope" do
      store_translations(:'messages.message' => 'message')
      assert_equal 'message', message(:message, :model => 'model', :attribute => 'attribute').to_s
    end
  end
end