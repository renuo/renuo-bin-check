require 'digest'

module RenuoBinCheck
  class Cacher
    def result(paths, command)
      files = paths.map { |path| Dir[path] }.flatten.sort
      hash = Digest::MD5.hexdigest files.map { |file| Digest::MD5.file(file).hexdigest if File.file? file }.to_s
      read(hash, command) if File.exist? "tmp/bin-check/#{command}/#{hash}"
    end

    private

    #:reek:UtilityFunction
    def read(hash, command)
      output = File.read("tmp/bin-check/#{command}/#{hash}/output")
      error_output = File.read("tmp/bin-check/#{command}/#{hash}/error_output")
      exit_code = File.read("tmp/bin-check/#{command}/#{hash}/exit_code").to_i
      CommandResult.new(output, error_output, exit_code)
    end
  end
end
