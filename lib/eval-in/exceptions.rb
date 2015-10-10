module EvalIn
	# A parent Error class for all eval-in errors.
	class EvalInError < RuntimeError
	end

	# Raised when EvalIn.{EvalIn.eval} is given a bad input language.
	class BadLanguageError < EvalInError
		def initialize(lang)
			super "No such language: #{lang}"
		end
	end

	# Raised when EvalIn.{EvalIn.eval} is given blank or whitespace-only code.
	class EmptyCodeError < EvalInError
		def initialize
			super "The code may not be empty"
		end
	end
end
