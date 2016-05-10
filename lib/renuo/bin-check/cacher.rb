require 'digest'
require 'fileutils'

module RenuoBinCheck
  class Cacher
    def initialize(name, paths)
      @name = name
      @file_names = paths.map { |path| Dir[path] }.flatten.sort
      @hash = hash_files
    end

    def exists?
      File.exist?("tmp/bin-check/#{@name}/#{@hash}")
    end

    def result
      read
    end

    def cache(result)
      FileUtils.mkdir_p "tmp/bin-check/#{@name}/#{@hash}"
      File.write "tmp/bin-check/#{@name}/#{@hash}/output", result.output
      File.write "tmp/bin-check/#{@name}/#{@hash}/error_output", result.error_output
      File.write "tmp/bin-check/#{@name}/#{@hash}/exit_code", result.exit_code
    end

    private

    def read
      output = File.read("tmp/bin-check/#{@name}/#{@hash}/output")
      error_output = File.read("tmp/bin-check/#{@name}/#{@hash}/error_output")
      exit_code = File.read("tmp/bin-check/#{@name}/#{@hash}/exit_code").to_i
      CommandResult.new(output, error_output, exit_code)
    end

    def hash_files
      Digest::MD5.hexdigest @file_names.map { |file_name| hash_file(file_name) if File.file? file_name }.to_s
    end

    #:reek:UtilityFunction
    def hash_file(file_name)
      Digest::MD5.file(file_name).hexdigest + Digest::MD5.hexdigest(file_name)
    end
  end
end
