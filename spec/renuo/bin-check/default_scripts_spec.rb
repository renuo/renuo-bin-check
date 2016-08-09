require 'spec_helper'
require './lib/renuo_bin_check/default_scripts'

RSpec.describe DefaultScripts do
  let(:default_scripts) { DefaultScripts.new }

  it 'uses all scripts needed for rails default' do
    expect(default_scripts).to receive(:todo)
    expect(default_scripts).to receive(:console_log)
    expect(default_scripts).to receive(:put_with_brackets)
    expect(default_scripts).to receive(:put_without_brackets)
    expect(default_scripts).to receive(:pp_and_p)
    expect(default_scripts).to receive(:p_with_brackets)
    expect(default_scripts).to receive(:rubocop_autocorrect)
    expect(default_scripts).to receive(:slim_lint)
    expect(default_scripts).to receive(:scss_lint)
    expect(default_scripts).to receive(:tslint)
    expect(default_scripts).to receive(:brakeman)
    expect(default_scripts).to receive(:reek)
    expect(default_scripts).to receive(:rspec)

    default_scripts.rails_defaults
  end

  it 'uses all scripts needed for rails default if coffee is used' do
    expect(default_scripts).to receive(:todo)
    expect(default_scripts).to receive(:console_log)
    expect(default_scripts).to receive(:put_with_brackets)
    expect(default_scripts).to receive(:put_without_brackets)
    expect(default_scripts).to receive(:pp_and_p)
    expect(default_scripts).to receive(:p_with_brackets)
    expect(default_scripts).to receive(:rubocop_autocorrect)
    expect(default_scripts).to receive(:slim_lint)
    expect(default_scripts).to receive(:scss_lint)
    expect(default_scripts).to receive(:coffeelint)
    expect(default_scripts).to receive(:brakeman)
    expect(default_scripts).to receive(:reek)
    expect(default_scripts).to receive(:rspec)

    default_scripts.rails_coffee_script_defaults
  end

  it '#no_default' do
    expect(default_scripts.no_defaults).to eq([])
  end

  it '#todo' do
    expect(default_scripts.todo.last.configs)
      .to eq(
        name: 'todo',
        command: "grep --exclude-dir='app/assets/typings/**' -i -r 'TODO' app spec config db Rakefile README.md Gemfile",
        reversed_exit: true, files: ['app/**/*', 'spec/**/*', 'config/**/*', 'db/**/*', 'Rakefile', 'README.md', 'Gemfile'],
        success_message: '+TODOs found. Please fix them and try again, commit aborted'
      )
  end

  it '#console_log' do
    expect(default_scripts.console_log.last.configs)
      .to eq(
        name: 'console_log',
        command: "grep -i -r 'console.log' app spec",
        reversed_exit: true,
        files: ['app/**/*', 'spec/**/*'],
        success_message: '+console.log found. Please fix them and try again, commit aborted'
      )
  end

  it '#put_without_brackets' do
    expect(default_scripts.put_without_brackets.last.configs)
      .to eq(
        name: 'put_without_brackets',
        command: "grep -i -r '  puts ' app spec",
        reversed_exit: true,
        files: ['app/**/*', 'spec/**/*'],
        success_message: '+puts found. Please fix them and try again, commit aborted'
      )
  end

  it '#put_with_brackets' do
    expect(default_scripts.put_with_brackets.last.configs)
      .to eq(
        name: 'put_with_brackets',
        command: "grep -i -r '  puts(' app spec",
        reversed_exit: true,
        files: ['app/**/*', 'spec/**/*'],
        success_message: '+puts( found. Please fix them and try again, commit aborted'
      )
  end

  it '#pp_and_p' do
    expect(default_scripts.pp_and_p.last.configs)
      .to eq(
        name: 'pp_and_p',
        command: "grep -i -r '(  pp? [^=])|(= pp? )' app spec",
        reversed_exit: true,
        files: ['app/**/*', 'spec/**/*'],
        success_message: '+p or pp found. Please fix them and try again, commit aborted'
      )
  end

  it '#p_with_brackets' do
    expect(default_scripts.p_with_brackets.last.configs)
      .to eq(
        name: 'p_with_brackets',
        command: "grep -i -r '  p(' app spec",
        reversed_exit: true,
        files: ['app/**/*', 'spec/**/*'],
        success_message: '+p( found. Please fix them and try again, commit aborted'
      )
  end

  it '#rubocop_autocorrect' do
    expect(default_scripts.rubocop_autocorrect.last.configs)
      .to eq(
        name: 'rubocop_autocorrect',
        command: 'bundle exec rubocop -a -D -c .rubocop.yml',
        files: ['app/**/*.rb', 'spec/**/*.rb'],
        error_message: '+Tried to auto correct the issues, but must be reviewed manually, commit aborted'
      )
  end

  it '#slim_lint' do
    expect(default_scripts.slim_lint.last.configs)
      .to eq(
        name: 'slim_lint',
        command: 'bundle exec slim-lint app/views/ -c .slim-lint.yml',
        files: ['app/views/**/*.slim'],
        error_message: '+slim-lint detected issues, commit aborted'
      )
  end

  it '#scss_lint' do
    expect(default_scripts.scss_lint.last.configs)
      .to eq(
        name: 'scss_lint',
        command: 'scss-lint app/assets/stylesheets/**/*.scss',
        files: ['app/assets/stylesheets/**/*.scss'],
        error_message: '+scss-lint detected issues, commit aborted'
      )
  end

  it '#tslint' do
    expect(default_scripts.tslint.last.configs)
      .to eq(
        name: 'tslint',
        command: 'tslint -c tslint.json app/assets/javascripts/**/*.ts',
        files: ['app/assets/javascripts/**/*.ts'],
        error_message: '+tslint detected issues, commit aborted'
      )
  end

  it '#coffeelint' do
    expect(default_scripts.coffeelint.last.configs)
      .to eq(
        name: 'coffeelint',
        command: 'coffeelint -f .coffeelint.json app/assets/javascripts/**/*.coffee',
        files: ['app/assets/javascripts/**/*.coffee'],
        error_message: '+coffeelint detected issues, commit aborted'
      )
  end

  it '#brakeman' do
    expect(default_scripts.brakeman.last.configs)
      .to eq(
        name: 'brakeman',
        command: 'bundle exec brakeman -q -z --summary > /dev/null',
        error_message: '+Brakeman has detected one or more security vulnerabilities, please review them and re-commit your changes, commit aborted'
      )
  end

  it '#reek' do
    expect(default_scripts.reek.last.configs)
      .to eq(
        name: 'reek',
        command: 'bundle exec reek',
        files: ['app/**/*.rb'],
        error_message: '+reek detected code smells, commit aborted'
      )
  end

  it '#rspec' do
    expect(default_scripts.rspec.last.configs)
      .to eq(
        name: 'rspec',
        command: 'bundle exec rspec',
        files: ['app/**/*.rb', 'spec/**/*.rb'],
        error_message: '+rspec did not run successfully, commit aborted'
      )
  end
end
