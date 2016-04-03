# logger-with\_stdout [![Build Status](https://travis-ci.org/key-amb/logger-with_stdout.svg?branch=master)](https://travis-ci.org/key-amb/logger-with_stdout)

This package provides `Logger::WithStdout`, a subclass of stdlib `Logger`.

It enables to create loggers which write logs to _STDOUT_ as well when _STDOUT_
is TTY.  
And it can also write logs to _STDERR_ by option.

## Usage

```ruby
require 'logger-with_stdout'

# STDOUT only
logger = Logger::WithStdout.new
# logfile and STDOUT
logger = Logger::WithStdout.new '/path/to/log'
# logdev and STDERR
logger = Logger::WithStdout.new io_obj, stdout: false, stderr: true
# Other options for Logger::new
logger = Logger::WithStdout.new io_obj, shift_age: 3, shift_size: 1024 * 1024 * 8
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logger-with_stdout'
```

And then run `bundle` command on your terminal.

Or install it yourself as:

```sh
% gem install logger-with_stdout
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
