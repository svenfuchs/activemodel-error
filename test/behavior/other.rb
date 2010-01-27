module Behavior  
  module NonFormatted
    # # e.g. validates_presence_of :email, :message => "message"
    # test "message is a String, format key :full given" do
    #   assert_equal 'message', message(:blank, 'message').to_s(:full)
    # end
    # 
    # # e.g. validates_presence_of :email / translations :blank => 'No email?'
    # test "no message given, format key :full given, translation is a String" do
    #   store_translations(:blank => 'No email?')
    #   assert_equal 'No email?', message(:blank).to_s(:full)
    # end
    # 
    # # e.g. validates_presence_of :email, :message => :foo / translations :foo => 'No email?'
    # test "message is a Symbol, format key :full given, translation is a String" do
    #   store_translations(:foo => 'No email?')
    #   assert_equal 'No email?', message(:blank, :foo).to_s(:full)
    # end
  end

  module TranslatedVariants
    # # validates_presence_of :email / translations :blank => { :short => 'No email?' }
    # test "no message given, format key :short given, translation is a Hash w/ :short key" do
    #   store_translations(:blank => { :short => 'No email?' })
    #   assert_equal 'No email?', message(:blank).to_s(:short)
    # end
    # 
    # not implemented
    # test "no message given, format key :full given, translation is a Hash w/ :short key" do
    #   store_translations(:blank => { :short => 'No email?' })
    #   assert_equal 'No email?', message(:blank).to_s(:full)
    # end
    
    # # validates_presence_of :email / translations :blank => { :short => 'No email?', :full => "full" }
    # test "no message given, format key :short given, translation is a Hash w/ :short and :full keys" do
    #   store_translations(:blank => { :short => 'No email?', :full => "full" })
    #   assert_equal 'No email?', message(:blank).to_s(:short)
    # end
    # 
    # test "no message given, format key :full given, translation is a Hash w/ :short and :full keys" do
    #   store_translations(:blank => { :short => 'No email?', :full => "full" })
    #   assert_equal "full", message(:blank).to_s(:full)
    # end
    # 
    # # e.g. validates_presence_of :email, :message => { :short => :foo } / translations :blank => { :short => 'No email?' }
    # test "message is a Hash, format key :short given, translation is a Hash w/ :short key" do
    #   store_translations(:foo => { :short => 'No email?' })
    #   assert_equal 'No email?', message(:blank, :short => :foo).to_s(:short)
    # end
    # 
    # # not implemented
    # # test "message is a Hash, format key :full given, translation is a Hash w/ :short key" do
    # #   store_translations(:foo => { :short => 'No email?' })
    # #   assert_equal 'No email?', message(:blank, :short => :foo).to_s(:full)
    # # end
    # 
    # # e.g. validates_presence_of :email, :message => { :short => :foo, :full => :foo } / translations :blank => { :short => 'No email?' }
    # test "message is a Hash, format key :short given, translation is a Hash w/ :short and :full key" do
    #   store_translations(:foo => { :short => 'No email?' })
    #   assert_equal 'No email?', message(:blank, :short => :foo, :full => :foo).to_s(:short)
    # end
    # 
    # # not implemented
    # # test "message is a Hash, format key :full given, translation is a Hash w/ :short and :full key" do
    # #   store_translations(:foo => { :short => 'No email?' })
    # #   assert_equal 'No email?', message(:blank, :short => :foo, :full => :foo).to_s(:full)
    # # end
  end
end