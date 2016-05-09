require './lib/renuo/bin-check/command_result'
FactoryGirl.define do
  factory :cacher, class: RenuoBinCheck::Cacher do
    command 'script_name'
    paths ['./spec/spec-files/file1', './spec/spec-files/file2']
    initialize_with { new(command, paths) }

    factory :not_found_cacher, class: RenuoBinCheck::Cacher do
      command 'script_name2'
    end
  end
end