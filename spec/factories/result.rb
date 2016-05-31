require './lib/renuo/bin-check/result'
FactoryGirl.define do
  factory :result, class: RenuoBinCheck::Result do
    output "I passed\nThis is the second line\n"
    error_output "I failed\nThis is the second line\n"
    exit_code 0
    initialize_with { new(output, error_output, exit_code) }

    factory :reversed_exit_result do
      error_output "I passed\nThis is the second line\n"
      output "I failed\nThis is the second line\n"
      exit_code 1
    end

    factory :overridden_output_result do
      output 'overridden output'
      error_output 'overridden error_output'
    end

    factory :appended_output_result do
      output "I passed\nThis is the second line\noverridden output"
      error_output "I failed\nThis is the second line\noverridden error_output"
    end

    factory :failed_result do
      exit_code 1
    end
  end
end
