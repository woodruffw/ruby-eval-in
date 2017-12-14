# frozen_string_literal: true

require "minitest/autorun"
require "eval-in"

# ruby-eval-in unit tests.
class EvalInTest < Minitest::Test
  def test_bad_language
    assert_raises EvalIn::BadLanguageError do
      EvalIn.eval "madeup", "abc"
    end
  end

  def test_empty_code
    empties = [
      "",
      " ",
      "\n",
      "\t\n",
      "\r\n",
      "\r\t\n",
      "  \t \r \n\n \t",
    ]

    empties.each do |empty|
      assert_raises EvalIn::EmptyCodeError do
        EvalIn.eval :ruby, empty
      end
    end
  end

  def test_eval_ok
    code = <<-CODE
      puts
    CODE

    result = EvalIn.eval(:ruby, code)

    assert_kind_of EvalIn::Result, result
    assert_equal "\n", result.output
    assert_match(/^OK/, result.status)
  end

  def test_eval_basic
    code = <<-CODE
      puts "Hello, World!"
    CODE

    result = EvalIn.eval(:ruby, code)

    assert_kind_of EvalIn::Result, result
    assert_equal "Hello, World!\n", result.output
    assert_match(/^OK/, result.status)
    assert_kind_of URI, result.url
  end

  def test_eval_syntax_error
    code = <<-CODE
      thisisnotvalidruby
    CODE

    result = EvalIn.eval(:ruby, code)

    assert_kind_of EvalIn::Result, result
    assert_match(/\/tmp\/execpad/, result.output)
    assert_equal "Exited with error status 1", result.status
  end
end
