require 'spec_helper'

require 'pathname'
require 'tempfile'

class StubStringIO < StringIO
  def initialize option={}
    @tty = option.key?(:tty) ? option[:tty] : true
    super()
  end
  def tty?
    @tty
  end
end

describe Logger::WithStdout do
  it 'has a version number' do
    expect(Logger::WithStdout::VERSION).not_to be nil
  end

  context 'With no logfile specified' do
    context 'when STDOUT is TTY' do
      $stdout = StubStringIO.new
      logger  = Logger::WithStdout.new
      it 'is Logger::WithStdout object' do
        expect(logger).to be_an_instance_of(Logger::WithStdout)
      end

      logger.info "we got stdout log"
      output = $stdout.string
      it "can write to STDOUT" do
        expect(output).to match(/we got stdout log/)
      end

      $stdout = STDOUT
    end

    context 'when STDOUT is not TTY' do
      it 'raise Logger::WithStdout::Error' do
        $stdout = StubStringIO.new tty: false
        expect { Logger::WithStdout.new }.to raise_error(
          Logger::WithStdout::Error, "No output device found!")
        $stdout = STDOUT
      end
    end
  end

  context 'With logdev specified' do
    context 'when STDOUT is TTY' do
      tmp = Tempfile.open 'tmp'
      $stdout = StubStringIO.new
      logger  = Logger::WithStdout.new tmp
      logger.info "we got stdout log"
      output  = $stdout.string
      it "can write to STDOUT" do
        expect(output).to match(/we got stdout log/)
      end

      tmp.flush
      content = File.open(tmp.path).read
      it "can write to logfile" do
        expect(content).to match(/we got stdout log/)
      end

      tmp.close
      $stdout = STDOUT
    end
  end

  context 'With logfile specified' do
    tmppath = Pathname(Dir.tmpdir).join('__logger-with_stdout.spec.log').to_s
    context 'when STDOUT is TTY' do
      $stdout = StubStringIO.new
      logger  = Logger::WithStdout.new tmppath
      logger.info "we got stdout log"
      output  = $stdout.string
      logger.close

      it "can write to STDOUT" do
        expect(output).to match(/we got stdout log/)
      end

      content = File.open(tmppath).read
      it "can write to logfile" do
        expect(content).to match(/we got stdout log/)
      end

      File.unlink tmppath
      $stdout = STDOUT
    end

    context 'when STDOUT and STDERR specified and available' do
      $stdout = StubStringIO.new
      $stderr = StubStringIO.new
      logger  = Logger::WithStdout.new(tmppath, stderr: true)
      logger.info "we got stdout log"
      output  = $stdout.string
      outerr  = $stderr.string
      logger.close

      it "can write to STDOUT" do
        expect(output).to match(/we got stdout log/)
      end
      it "can write to STDERR" do
        expect(outerr).to match(/we got stdout log/)
      end

      content = File.open(tmppath).read
      it "can write to logfile" do
        expect(content).to match(/we got stdout log/)
      end

      File.unlink tmppath
      $stdout = STDOUT
      $stderr = STDERR
    end
  end
end
