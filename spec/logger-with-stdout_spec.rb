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

describe LoggerWithStdout do
  it 'has a version number' do
    expect(LoggerWithStdout::VERSION).not_to be nil
  end

  context 'With no logfile specified' do
    context 'when STDOUT is TTY' do
      $stdout = StubStringIO.new
      logger  = LoggerWithStdout.logger
      it 'is LoggerWithStdout object' do
        expect(logger).to be_an_instance_of(Logger)
      end

      logger.info "we got stdout log"
      output = $stdout.string
      it "can write to STDOUT" do
        expect(output).to match(/we got stdout log/)
      end

      $stdout = STDOUT
    end

    context 'when STDOUT is not TTY' do
      context 'without any option' do
        it 'raise LoggerWithStdout::Error' do
          $stdout = StubStringIO.new tty: false
          expect { LoggerWithStdout.logger }.to raise_error(
            LoggerWithStdout::Error, "No output device found!")
          $stdout = STDOUT
        end
      end
      context 'with :allow_no_dev option' do
        $stdout = StubStringIO.new tty: false
        logger  = LoggerWithStdout.logger nil, allow_nodev: true
        logger.info 'No log written'
        output  = $stdout.string
        $stdout = STDOUT
        it 'is LoggerWithStdout object' do
          expect(logger).to be_an_instance_of(Logger)
        end
        it 'no log written' do
          expect(output).to eq ""
        end
      end
    end
  end

  context 'With logdev specified' do
    context 'when STDOUT is TTY' do
      tmp = Tempfile.open 'tmp'
      $stdout = StubStringIO.new
      logger  = LoggerWithStdout.logger tmp
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
    tmppath = Pathname(Dir.tmpdir).join('__logger-with-stdout.spec.log').to_s
    context 'when STDOUT is TTY' do
      $stdout = StubStringIO.new
      logger  = LoggerWithStdout.logger tmppath
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
      logger  = LoggerWithStdout.logger(tmppath, stderr: true)
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
