ruby-eval-in
============

![license](https://raster.shields.io/badge/license-MIT%20with%20restrictions-green.png)
[![Gem Version](https://badge.fury.io/rb/ruby-eval-in.svg)](http://badge.fury.io/rb/ruby-eval-in)
[![Build Status](https://travis-ci.org/woodruffw/ruby-eval-in.svg?branch=master)](https://travis-ci.org/woodruffw/ruby-eval-in)


**WARNING:** The web service exposed by this gem is no longer online, and this gem is no longer
maintained.

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
