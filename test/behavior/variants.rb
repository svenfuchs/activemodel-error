module Behavior
  module Variants
    # e.g. validates_presence_of :email, :message => "message"
    test "subject is a Message, variant :short" do
      assert_equal 'message', message('message').to_s(:short)
    end

    test "subject is a Message, variant :full" do
      assert_equal 'message', message('message').to_s(:full)
    end

    # e.g. validates_presence_of :email, :message => { :short => "short", :full => "full" } }
    test "subject is a Hash w/ :short and :full messages, variant :short" do
      assert_equal 'short', message(:short => 'short', :full => "full").to_s(:short)
    end
    
    test "subject is a Hash w/ :short and :full messages, variant :full" do
      assert_equal "full", message(:short => 'short', :full => "full").to_s(:full)
    end
  end
end