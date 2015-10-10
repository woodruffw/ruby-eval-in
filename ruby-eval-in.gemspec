require_relative './lib/eval-in.rb'

Gem::Specification.new do |s|
	s.name = 'ruby-eval-in'
	s.version = EvalIn::VERSION.dup
	s.date = '2015-08-07'
	s.required_ruby_version = '>= 2.0.0'
	s.summary = 'ruby-eval-in - A Ruby interface to https://eval.in/.'
	s.description = 'A Ruby interface to https://eval.in/.'
	s.authors = ['William Woodruff']
	s.email = 'william@tuffbizz.com'
	s.files = Dir['LICENSE', 'README.md', '.yardopts', 'lib/**/*']
	s.add_dependency 'mechanize'
	s.add_dependency 'nokogiri'
	s.bindir = 'bin'
	s.executables << 'eval-in'
	s.homepage = 'https://github.com/woodruffw/ruby-eval-in'
	s.license = 'MIT'
end
