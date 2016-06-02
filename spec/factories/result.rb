require './lib/renuo/bin-check/result'
FactoryGirl.define do
  factory :result, class: RenuoBinCheck::Result do
    standard_output "I passed\nThis is the second line\n"
    error_output "I failed\nThis is the second line\n"
    exit_code 0
    initialize_with { new(standard_output, error_output, exit_code) }

    factory :reversed_exit_result do
      error_output "I passed\nThis is the second line\n"
      standard_output "I failed\nThis is the second line\n"
      exit_code 1
    end

    factory :overridden_output_result do
      standard_output 'overridden standard_output'
      error_output 'overridden error_output'
    end

    factory :appended_output_result do
      standard_output "I passed\nThis is the second line\noverridden standard_output"
      error_output "I failed\nThis is the second line\noverridden error_output"
    end

    factory :failed_result do
      exit_code 1
    end
  end
end
