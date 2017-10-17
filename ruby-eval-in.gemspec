# frozen_string_literal: true

require_relative "lib/eval-in"

Gem::Specification.new do |s|
  s.name = "ruby-eval-in"
  s.version = EvalIn::VERSION
  s.required_ruby_version = ">= 2.0.0"
  s.summary = "ruby-eval-in - A Ruby interface to https://eval.in/."
  s.description = "A Ruby interface to https://eval.in/."
  s.authors = ["William Woodruff"]
  s.email = "william@tuffbizz.com"
  s.files = Dir["LICENSE", "README.md", ".yardopts", "lib/**/*.rb"]
  s.add_dependency "nokogiri"
  s.bindir = "bin"
  s.executables << "eval-in"
  s.homepage = "https://github.com/woodruffw/ruby-eval-in"
  s.license = "MIT"
end
