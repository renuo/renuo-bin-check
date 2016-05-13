require './lib/renuo/bin-check/result'
FactoryGirl.define do
  factory :result, class: RenuoBinCheck::Result do
    output "I passed\nThis is the second line\n"
    error_output "I failed\nThis is the second line\n"
    exit_code 0
    initialize_with { new(output, error_output, exit_code) }

    factory :failed_result do
      exit_code 1
    end
  end
end
