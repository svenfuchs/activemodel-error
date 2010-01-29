require 'active_support/core_ext/class/attribute_accessors'
require 'active_model'

module ActiveModel
  autoload :Error, 'active_model/error'
end

class ActiveModel::Errors
  cattr_accessor :error_class
  @@error_class = ActiveModel::Error

  def generate_message(attribute, type = :invalid, options = {})
    options.update(:model => @base.class.model_name, :attribute => attribute)
    error_class.new(options.delete(:default) || type, options)
  end
end
