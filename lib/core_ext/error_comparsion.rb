class Array
  def equals_with_active_model_errors(other)
    other = other.map { |e| e.to_s } if ActiveModel::AttributeErrors === other
    equals_without_active_model_errors(other)
  end
  alias equals_without_active_model_errors ==
  alias == equals_with_active_model_errors
end

class String
  def equals_with_active_model_error(other)
    other = other.to_s if ActiveModel::Error === other
    equals_without_active_model_error(other)
  end
  alias equals_without_active_model_error ==
  alias == equals_with_active_model_error

  def compare_with_active_model_error(other)
    other = other.to_s if ActiveModel::Error === other
    compare_without_active_model_error(other)
  end
  alias compare_without_active_model_error <=>
  alias <=> compare_with_active_model_error
end

