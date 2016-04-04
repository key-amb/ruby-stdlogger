# logger-with-stdout
[![Gem Version](https://badge.fury.io/rb/logger-with-stdout.svg)](https://badge.fury.io/rb/logger-with-stdout)
[![Build Status](https://travis-ci.org/key-amb/logger-with-stdout.svg?branch=master)](https://travis-ci.org/key-amb/logger-with-stdout)

This package enables to create `Logger` object which writes logs to _STDOUT_ in
addition to specified log device when _STDOUT_ is TTY.  
And it can also write logs to _STDERR_ by option.

Rewritten from [logger-with_stdout](https://github.com/key-amb/logger-with_stdout).

## Usage

```ruby
require 'logger-with-stdout'

# STDOUT only
logger = LoggerWithStdout.logger
# logfile and STDOUT
logger = LoggerWithStdout.logger '/path/to/log'
# logdev and STDERR
logger = LoggerWithStdout.logger io_obj, stdout: false, stderr: true
# Other options for Logger::new
logger = LoggerWithStdout.logger io_obj, shift_age: 3, shift_size: 1024 * 1024 * 8
# Doesn't raise error when STDOUT is not TTY
logger = LoggerWithStdout.logger nil, allow_nodev: true
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logger-with-stdout'
```

And then run `bundle` command on your terminal.

Or install it yourself as:

```sh
% gem install logger-with-stdout
```

## Spetial Thanks

Thanks to [David](http://stackoverflow.com/users/796195/david) who gave me the
idea of `MultiIO`.

It is illustrated as [answer to a question in Stack Overflow](http://stackoverflow.com/a/6407200/6150943).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## License

The MIT License (MIT)

Copyright (c) 2016 YASUTAKE Kiyoshi
