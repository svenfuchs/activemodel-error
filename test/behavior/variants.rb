module Behavior
  module Variants
    # e.g. validates_presence_of :email, :message => "message"
    test "subject is a String, format key :short given" do
      assert_equal 'message', string('message').to_s(:short)
    end

    test "subject is a String, format key :full given" do
      assert_equal 'message', string('message').to_s(:full)
    end

    # e.g. validates_presence_of :email, :message => { :short => "short", :full => "full" } }
    test "subject is a Hash w/ :short and :full messages, format key :short given" do
      assert_equal 'short', string(:short => 'short', :full => "full").to_s(:short)
    end
    
    test "subject is a Hash w/ :short and :full messages, format key :full given" do
      assert_equal "full", string(:short => 'short', :full => "full").to_s(:full)
    end
  end
end