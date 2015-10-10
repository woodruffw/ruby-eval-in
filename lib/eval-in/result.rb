require 'nokogiri'
require 'mechanize'
require 'uri'

module EvalIn
	# A representation of a result produced by an eval.in query.
	class Result
		# @private
		URL = "https://eval.in"

		# The languages supported by eval.in.
		# Any of these keys or values will work for the lang parameter in
		#  {EvalIn.eval}.
		LANGS = {
			"c" => "c/gcc-4.9.1",
			"c++" => "c++/gcc-4.9.1",
			"coffeescript" => "coffeescript/node-0.10.29-coffee-1.7.1",
			"fortran" => "fortran/f95-4.4.3",
			"haskell" => "haskell/hugs98-sep-2006",
			"io" => "io/io-20131204",
			"js" => "javascript/node-0.10.29",
			"lua" => "lua/lua-5.2.3",
			"ocaml" => "ocaml/ocaml-4.01.0",
			"php" => "php/php-5.5.14",
			"pascal" => "pascal/fpc-2.6.4",
			"perl" => "perl/perl-5.20.0",
			"python" => "python/cpython-3.4.1",
			"ruby" => "ruby/mri-2.2",
			"slash" => "slash/slash-head",
			"nasm" => "assembly/nasm-2.07"
		}

		# @return [String] the expanded language used in execution
		# @example
		#  result.language # => "ruby/mri-2.2"
		attr_reader :language

		# @return [String] the program code used in execution
		# @example
		#  result.code # => "puts \"hello\""
		attr_reader :code

		# @return [String] any output produced by the program
		# @example
		#  result.output # => "hello\n"
		attr_reader :output

		# @return [String] the program's exit status
		# @example
		#  result.status # => "OK (0 sec real, 0 sec wall, 8 MB, 16 syscalls)"
		attr_reader :status

		# @return [URI] a permalink to the output webpage
		# @example
		#  result.url # => #<URI::HTTPS https://eval.in/xxxxxx>
		attr_reader :url

		# @private
		def initialize(lang, code)
			if LANGS.key?(lang)
				lang = LANGS[lang]
			elsif !LANGS.value?(lang)
				raise BadLanguageError.new(lang)
			end

			raise EmptyCodeError.new if code.strip.empty?

			@lang = lang
			@code = code
			@html = get_page
			@output = get_output
			@status = get_status
			@url = get_url
		end

		private

		def get_page
			mech = Mechanize.new
			page = mech.get(URL)
			form = page.forms.first

			form.field_with(:name => "code").value = @code
			form.field_with(:name => "lang").value = @lang
			Nokogiri::HTML(mech.submit(form).body)
		end

		def get_output
			@html.css("pre").last.text
		end

		def get_status
			@html.css("p")[1].text
		end

		def get_url
			number = @html.css("h2").first.text.delete("Paste \#")
			URI("https://eval.in/#{number}")
		end
	end
end
