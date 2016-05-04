require './lib/renuo/bin-check/command_result'
FactoryGirl.define do
  factory :result, class: RenuoBinCheck::CommandResult do
    output 'No errors, yeyy!!'
    error_output 'Oh no an error :('
    exit_code '0'

    factory :faild_result do
      return_value '1'
    end
  end
end
