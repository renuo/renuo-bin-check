require './lib/renuo/bin-check/command_result'
FactoryGirl.define do
  factory :result, class: RenuoBinCheck::CommandResult do
    output "I passed\nThis is the second line\n"
    error_output "I failed\nThis is the second line\n"
    exit_code 0
    initialize_with { new(output, error_output, exit_code) }

    factory :reversed_exit_result do
      error_output "I passed\nThis is the second line\n"
      output "I failed\nThis is the second line\n"
      exit_code 1
    end

    factory :failed_result do
      exit_code 1
    end
  end
end
