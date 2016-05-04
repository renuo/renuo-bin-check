require './lib/renuo/bin-check/command_result'
FactoryGirl.define do
  factory :result, class: RenuoBinCheck::CommandResult do
    output "I have been running\nNow I'm tired\n"
    error_output "I couldn't run :'(\nplease motivate me to\n"
    exit_code 0
    initialize_with { new(output, error_output, exit_code) }

    factory :faild_result do
      return_value '1'
    end
  end
end
