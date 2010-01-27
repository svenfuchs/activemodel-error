module Behavior
  module Variants
    # e.g. validates_presence_of :email, :message => "message"
    test "message is a String, format key :short given" do
      assert_equal 'message', message(:blank, 'message').to_s(:short)
    end

    test "message is a String, format key :full given" do
      assert_equal 'message', message(:blank, 'message').to_s(:full)
    end

    # e.g. validates_presence_of :email, :message => { :short => "short", :full => "full" } }
    test "message is a Hash w/ :short and :full messages, format key :short given" do
      assert_equal 'short', message(:blank, :short => 'short', :full => "full").to_s(:short)
    end
    
    test "message is a Hash w/ :short and :full messages, format key :full given" do
      assert_equal "full", message(:blank, :short => 'short', :full => "full").to_s(:full)
    end
  end
end