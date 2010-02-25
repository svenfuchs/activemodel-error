module Behavior
  module Cascade
    test "returns translation from attribute scope" do
      store_translations(:'models.model.attributes.attribute.message' => 'message')
      assert_equal 'message', message(:message, :model => 'model', :attribute => 'attribute').to_s
    end

    test "returns translation from model scope" do
      store_translations(:'models.model.message' => 'message')
      assert_equal 'message', message(:message, :model => 'model', :attribute => 'attribute').to_s
    end

    test "returns translation from errors scope" do
      store_translations(:message => 'message')
      assert_equal 'message', message(:message, :model => 'model', :attribute => 'attribute').to_s
    end
  end
end