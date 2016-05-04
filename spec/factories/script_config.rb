require './lib/renuo/bin-check/script_config'
FactoryGirl.define do
  factory :script, class: RenuoBinCheck::ScriptConfig do
    script_command 'cool command'
    script_files %w(cool_file1 cool_file1)

    factory :failing_script do
      script_command './spec/spec-files/test_script_exit1'
    end

    factory :passing_script do
      script_command './spec/spec-files/test_script_exit0'
    end
  end
end
