module Behavior
  module Variants
    # e.g. validates_presence_of :email, :message => { :short => "short", :full => "full" } }
    test "message is a Hash w/ :short and :full messages, format key :short given" do
      assert_equal 'short', message(:blank, :short => 'short', :full => "full").to_s(:short)
    end

    test "message is a Hash w/ :short and :full messages, format key :full given" do
      assert_equal "full", message(:blank, :short => 'short', :full => "full").to_s(:full)
    end
  
    # validates_presence_of :email / translations :blank => { :short => 'No email?' }
    test "no message given, format key :short given, translation is a Hash w/ :short key" do
      store_translations(:blank => { :short => 'No email?' })
      assert_equal 'No email?', message(:blank).to_s(:short)
    end

    # not implemented
    # test "no message given, format key :full given, translation is a Hash w/ :short key" do
    #   store_translations(:blank => { :short => 'No email?' })
    #   assert_equal 'No email?', message(:blank).to_s(:full)
    # end

    # validates_presence_of :email / translations :blank => { :short => 'No email?', :full => "full" }
    test "no message given, format key :short given, translation is a Hash w/ :short and :full keys" do
      store_translations(:blank => { :short => 'No email?', :full => "full" })
      assert_equal 'No email?', message(:blank).to_s(:short)
    end

    test "no message given, format key :full given, translation is a Hash w/ :short and :full keys" do
      store_translations(:blank => { :short => 'No email?', :full => "full" })
      assert_equal "full", message(:blank).to_s(:full)
    end

    # e.g. validates_presence_of :email, :message => { :short => :foo } / translations :blank => { :short => 'No email?' }
    test "message is a Hash, format key :short given, translation is a Hash w/ :short key" do
      store_translations(:foo => { :short => 'No email?' })
      assert_equal 'No email?', message(:blank, :short => :foo).to_s(:short)
    end

    # not implemented
    # test "message is a Hash, format key :full given, translation is a Hash w/ :short key" do
    #   store_translations(:foo => { :short => 'No email?' })
    #   assert_equal 'No email?', message(:blank, :short => :foo).to_s(:full)
    # end

    # e.g. validates_presence_of :email, :message => { :short => :foo, :full => :foo } / translations :blank => { :short => 'No email?' }
    test "message is a Hash, format key :short given, translation is a Hash w/ :short and :full key" do
      store_translations(:foo => { :short => 'No email?' })
      assert_equal 'No email?', message(:blank, :short => :foo, :full => :foo).to_s(:short)
    end

    # not implemented
    # test "message is a Hash, format key :full given, translation is a Hash w/ :short and :full key" do
    #   store_translations(:foo => { :short => 'No email?' })
    #   assert_equal 'No email?', message(:blank, :short => :foo, :full => :foo).to_s(:full)
    # end
  end
end