require 'digest'
require 'fileutils'

module RenuoBinCheck
  class Cacher
    def result(paths, command)
      files = paths.map { |path| Dir[path] }.flatten.sort
      hash = hash_files(files)
      File.exist?("tmp/bin-check/#{command}/#{hash}") ? read(hash, command) : hash
    end

    #:reek:UtilityFunction
    def cache(result, command, hash)
      FileUtils.mkdir_p "tmp/bin-check/#{command}/#{hash}"
      File.write "tmp/bin-check/#{command}/#{hash}/output", result.output
      File.write "tmp/bin-check/#{command}/#{hash}/error_output", result.error_output
      File.write "tmp/bin-check/#{command}/#{hash}/exit_code", result.exit_code
    end

    private

    #:reek:UtilityFunction
    def read(hash, command)
      output = File.read("tmp/bin-check/#{command}/#{hash}/output")
      error_output = File.read("tmp/bin-check/#{command}/#{hash}/error_output")
      exit_code = File.read("tmp/bin-check/#{command}/#{hash}/exit_code").to_i
      CommandResult.new(output, error_output, exit_code)
    end

    #:reek:UtilityFunction
    def hash_files(files)
      Digest::MD5.hexdigest files.map { |file| Digest::MD5.file(file).hexdigest if File.file? file }.to_s
    end
  end
end
