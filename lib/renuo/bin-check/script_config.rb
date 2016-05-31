module RenuoBinCheck
  # :reek:TooManyInstanceVariables:
  class ScriptConfig
    attr_accessor :script_command, :script_files, :script_name, :script_reversed_exit, :script_output,
                  :script_error_output, :appended_output, :appended_error_output

    def command(command)
      @script_command = command
    end

    def files(files)
      @script_files = files
    end

    def name(name)
      @script_name = name
    end

    def output(output)
      output[0] == '+' ? @appended_output = output.sub('+', '') : @script_output = output
    end

    def error_output(error_output)
      error_output[0] == '+' ? @appended_error_output = error_output.sub('+', '') : @script_error_output = error_output
    end

    def reversed_exit(reversed_exit)
      @script_reversed_exit = reversed_exit
    end

    def script_name
      @script_name ||= Digest::MD5.hexdigest(@script_command)
    end

    def reversed_exit?
      @script_reversed_exit
    end

    def appended_output
      @appended_output ||= ''
    end

    def appended_error_output
      @appended_error_output ||= ''
    end

    def script_command
      raise 'There must be a command set for each script you want to run. Find further instruction on how to use this' \
' Gem here in the Readme: https://github.com/renuo/renuo-bin-check' unless @script_command
      @script_command
    end
  end
end
