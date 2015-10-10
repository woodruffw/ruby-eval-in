# eval-in.rb
# Author: William Woodruff
# A Ruby interface to the eval.in (https://eval.in) service.

require "eval-in/result"
require "eval-in/exceptions"

# The primary namespace.
# @author William Woodruff
# @since 0.0.1
module EvalIn
	# Evaluate some code in a given language.
	# @example
	#  EvalIn.eval(:ruby, 'puts "Hello, World"') # => #<EvalIn::Result:0xNN>
	# @param [Symbol, String] lang the language to execute in
	# @param [String] code the program code to execute
	# @return [EvalIn::Result] the execution results
	def self.eval(lang, code)
		EvalIn::Result.new(lang.to_s.downcase, code)
	end
end
