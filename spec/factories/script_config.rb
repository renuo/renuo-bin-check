require './lib/renuo/bin-check/script_config'
FactoryGirl.define do
  factory :script, class: RenuoBinCheck::ScriptConfig do
    script_command 'cool command'
    script_name 'script_name'
    script_files %w(cool_file1 cool_file1)
    script_reversed_exit false

    factory :failing_script do
      script_command './spec/spec-files/test_script_exit1'
      script_name 'exit1'
    end

    factory :passing_script do
      script_command './spec/spec-files/test_script_exit0'
      script_name 'exit0'

      factory :without_files_script do
        script_files nil
      end

      factory :reversed_exit_script do
        script_reversed_exit true
      end
    end

    factory :cached_script do
      script_command 'script_name'
      script_files ['./spec/spec-files/file1', './spec/spec-files/file2']
    end
  end
end
