ruby-eval-in
============

[![Gem Version](https://badge.fury.io/rb/ruby-eval-in.svg)](http://badge.fury.io/rb/ruby-eval-in)
[![Build Status](https://drone.io/github.com/woodruffw/ruby-eval-in/status.png)](https://drone.io/github.com/woodruffw/ruby-eval-in/latest)

A basic Ruby interface to the [eval.in](https://eval.in) online evaluation
service.

## Installation

`ruby-eval-in` can be installed as a RubyGem:

```bash
$ gem install ruby-eval-in
```

## Examples

Making queries is very simple:

```ruby
require 'eval-in'

result = EvalIn.eval(:ruby, 'puts 10**2')

result.output # => "100\n"
result.status # => "OK (0 sec real, 0 sec wall, 8 MB, 16 syscalls)"
result.url # => #<URI::HTTPS https://eval.in/xxxxxx>
```

The provided command line script can also be used:

```bash
$ eval-in ruby 'puts 10**2'
# 100
```

## License

`ruby-eval-in` is licensed under the MIT License.

See the LICENSE file for more details.
