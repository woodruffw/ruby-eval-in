require 'nokogiri'
require 'net/http'
require 'uri'

module EvalIn
	# A representation of a result produced by an eval.in query.
	class Result
		# @private
		URL = URI("https://eval.in")

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
			"python2" => "python/cpython-2.7.8",
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

			result = Net::HTTP.post_form(URL,
				"execute" => "on",
				"lang" => lang,
				"code" => code
			)

			if result.is_a? Net::HTTPFound
				@url = URI(result["location"])

				html = Nokogiri::HTML(Net::HTTP.get(@url))
				@output = html.css("pre").last.text
				@status = html.css("p")[1].text
			else
				raise ConnectionError.new(result)
			end
		end
	end
end
