require 'logger'

require "logger-with-stdout/error"
require "logger-with-stdout/multi_io"
require "logger-with-stdout/version"

module LoggerWithStdout

  # When no target device available, this method raises LoggerWithStdout::Error
  # without ':allow_nodev' option.
  # @param logdev [String, IO] path to logfile or writable IO object.
  # @param options [Hash]
  # @option options [String] :stdout (true) log to STDOUT or not.
  # @option options [String] :stderr (false) log to STDERR or not.
  # @option options [String] :shift_age (0)
  #  'shift_age' param for Logger#new
  # @option options [String] :shift_size (1048576)
  #  'shift_size' param for Logger#new
  # @option options [String] :allow_nodev (nil)
  #  don't raise error even if no target device available
  # @return [Logger]
  def self.logger logdev=nil, options={}
    stdout     = options[:stdout] || true
    stderr     = options[:stderr] || false
    shift_age  = options[:shift_age]  || 0
    shift_size = options[:shift_size] || 1048576

    targets = []
    if logdev
      if logdev.class == String
        targets << File.open(logdev, 'a')
      else
        targets << logdev
      end
    end
    targets << $stdout if (stdout and $stdout.tty?)
    targets << $stderr if (stderr and $stderr.tty?)
    if targets.empty? and !options[:allow_nodev]
      raise Error, "No output device found!"
    end
    multi_dev = MultiIO.new targets

    Logger.new multi_dev, shift_age, shift_size
  end
end
