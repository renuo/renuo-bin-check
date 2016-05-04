module RenuoBinCheck
  class ScriptConfig
    attr_accessor :script_command, :script_files
    def command(command)
      @script_command = command
    end

    def files(files)
      @script_files = files
    end
  end
end
