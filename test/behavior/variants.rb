module Behavior
  module Variants
    # e.g. validates_presence_of :email, :message => "message"
    test "subject is a String, variant :short" do
      assert_equal 'message', string('message').to_s(:short)
    end

    test "subject is a String, variant :full" do
      assert_equal 'message', string('message').to_s(:full)
    end

    # e.g. validates_presence_of :email, :message => { :short => "short", :full => "full" } }
    test "subject is a Hash w/ :short and :full messages, variant :short" do
      assert_equal 'short', string(:short => 'short', :full => "full").to_s(:short)
    end
    
    test "subject is a Hash w/ :short and :full messages, variant :full" do
      assert_equal "full", string(:short => 'short', :full => "full").to_s(:full)
    end
  end
end