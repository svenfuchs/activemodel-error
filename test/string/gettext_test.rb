# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class I18nMessageGettextTest < Test::Unit::TestCase
  class Message < I18n::Message
    include Gettext
  end

  def setup
    store_translations(
      :foo      => 'foo',
      :message  => 'message',
      :'%{foo}' => '%{foo}'
    )
  end

  include Behavior::Base
  include Behavior::Gettext
end