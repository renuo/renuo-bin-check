require './lib/renuo/bin-check/script_config'
FactoryGirl.define do
  factory :script, class: RenuoBinCheck::ScriptConfig do
    script_command 'cool command'
    script_files %w(cool_file1 cool_file1)
  end
end
