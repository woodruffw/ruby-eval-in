# frozen_string_literal: true

require_relative "eval-in/result"
require_relative "eval-in/exceptions"

# The primary namespace.
# @author William Woodruff
# @since 0.0.1
module EvalIn
  # The library's current version.
  VERSION = "0.0.5"

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
