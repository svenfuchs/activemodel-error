# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class AllFeaturesTest < Test::Unit::TestCase
  class Message < ::Message
    include Cascade
    include Formatted
    include Variants

    def options
      super.merge(:scope => :'models.model.attributes.attribute') 
    end
    
    # TODO remove this knowledge from Formatted#scope
    def model; 'model' end
    def attribute; 'attribute' end
  end

  def setup
    I18n.backend  = CascadingBackend.new
    Message.cascade_options = { :step => 2, :skip_root => false }
    store_translations(:'errors.formats' => { :short => '{{message}}', :full => 'full {{message}}' })
  end

  include Behavior::Message::Common
  include Behavior::Variants
  include Behavior::Cascade
  include Behavior::Formatted
end