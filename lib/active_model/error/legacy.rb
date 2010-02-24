module ActiveModel
  class Error < I18n::String
    module Legacy
    protected

      def translate_options(subject, variant = nil)
        defaults = base.class.lookup_ancestors.map do |klass|
          [ :"models.#{klass.name.underscore}.attributes.#{attribute}.#{subject}",
            :"models.#{klass.name.underscore}.#{subject}" ]
        end.flatten

        defaults << :"messages.#{subject}"

        options = @options.merge(
          :scope     => :errors,
          :default   => defaults,
          :model     => base.class.model_name.human,
          :attribute => base.class.human_attribute_name(attribute),
          :value     => value,
          :raise     => true
        )
      end
    end
  end
end