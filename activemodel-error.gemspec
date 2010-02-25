# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in RakeFile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{activemodel-error}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sven Fuchs", "Mateo Murphy"]
  s.date = %q{2010-02-25}
  s.description = %q{Provides I18n support for validation error messages in ActiveModel.
                      With Rails 3 ActiveModel validation error messages are not backwards
                      compatible with ActiveRecord 2.3.x. This Gem aims to restore this 
                      backwards compatiblity and provide a richer feature set and better
                      implementation compared to ActiveRecord 2.3.x.}
  s.extra_rdoc_files = [
    "README.textile"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.textile",
     "RakeFile",
     "VERSION",
     "lib/active_model/attribute_errors.rb",
     "lib/active_model/error.rb",
     "lib/active_model/error/base.rb",
     "lib/active_model/error/format.rb",
     "lib/active_model/error/legacy.rb",
     "lib/active_model/errors_ext.rb",
     "lib/activemodel_error.rb",
     "lib/core_ext/error_comparsion.rb",
     "test/active_model/format_test.rb",
     "test/active_model/interpolation_test.rb",
     "test/active_model/lookup_test.rb",
     "test/active_model/variants_test.rb",
     "test/active_model_test.rb",
     "test/all.rb",
     "test/run_active_model_tests.rb",
     "test/test_case_declarative.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/svenfuchs/activemodel-error}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{I18n for validation error messages in ActiveModel}
  s.test_files = [
    "test/active_model/format_test.rb",
     "test/active_model/interpolation_test.rb",
     "test/active_model/lookup_test.rb",
     "test/active_model/variants_test.rb",
     "test/active_model_test.rb",
     "test/all.rb",
     "test/run_active_model_tests.rb",
     "test/test_case_declarative.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

