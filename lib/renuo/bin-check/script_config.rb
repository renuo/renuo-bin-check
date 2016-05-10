module RenuoBinCheck
  class ScriptConfig
    attr_accessor :script_command, :script_files, :script_name
    def command(command)
      @script_command = command
    end

    def files(files)
      @script_files = files
    end

    def name(name)
      @script_name = name
    end

    def script_name
      @script_name ||= Digest::MD5.hexdigest(@script_command)
    end
  end
end
