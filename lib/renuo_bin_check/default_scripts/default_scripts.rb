require 'renuo_bin_check/dsl_config'

# rubocop:disable Metrics/ClassLength
# :reek:TooManyMethods
class DefaultScripts
  def initialize
    @default_scripts = []
  end

  def no_defaults
    []
  end

  # rubocop:disable Metrics/MethodLength
  # :reek:TooManyStatements
  def rails_defaults
    todo
    console_log
    puts_with_brackets
    puts_without_brackets
    pp_and_p
    p_with_brackets
    rubocop_autocorrect
    slim_lint
    scss_lint
    tslint
    brakeman
    reek
    rspec
    @default_scripts
  end

  # :reek:TooManyStatements
  def rails_coffee_script_defaults
    todo
    console_log
    puts_with_brackets
    puts_without_brackets
    pp_and_p
    p_with_brackets
    rubocop_autocorrect
    slim_lint
    scss_lint
    coffeelint
    brakeman
    reek
    rspec
    @default_scripts
  end
  # rubocop:enable Metrics/MethodLength

  def todo
    @default_scripts << DSLConfig.new('todo') do
      command "grep --exclude-dir='app/assets/typings/**' -i -r 'TODO' app spec config db Rakefile README.md Gemfile"
      reversed_exit true
      files ['app/**/*', 'spec/**/*', 'config/**/*', 'db/**/*', 'Rakefile', 'README.md', 'Gemfile']
      success_message '+TODOs found. Please fix them and try again, commit aborted'
    end
  end

  def console_log
    @default_scripts << DSLConfig.new('console_log') do
      command "grep -i -r 'console.log' app spec"
      reversed_exit true
      files ['app/**/*', 'spec/**/*']
      success_message '+console.log found. Please fix them and try again, commit aborted'
    end
  end

  def puts_without_brackets
    @default_scripts << DSLConfig.new('puts_without_brackets') do
      command "grep -i -r '  puts ' app spec"
      reversed_exit true
      files ['app/**/*', 'spec/**/*']
      success_message '+puts found. Please fix them and try again, commit aborted'
    end
  end

  def puts_with_brackets
    @default_scripts << DSLConfig.new('puts_with_brackets') do
      command "grep -i -r '  puts(' app spec"
      reversed_exit true
      files ['app/**/*', 'spec/**/*']
      success_message '+puts( found. Please fix them and try again, commit aborted'
    end
  end

  def pp_and_p
    @default_scripts << DSLConfig.new('pp_and_p') do
      command "grep -i -r '(  pp? [^=])|(= pp? )' app spec"
      reversed_exit true
      files ['app/**/*', 'spec/**/*']
      success_message '+p or pp found. Please fix them and try again, commit aborted'
    end
  end

  def p_with_brackets
    @default_scripts << DSLConfig.new('p_with_brackets') do
      command "grep -i -r '  p(' app spec"
      reversed_exit true
      files ['app/**/*', 'spec/**/*']
      success_message '+p( found. Please fix them and try again, commit aborted'
    end
  end

  def rubocop_autocorrect
    @default_scripts << DSLConfig.new('rubocop_autocorrect') do
      command 'bundle exec rubocop -a -D -c .rubocop.yml'
      files ['app/**/*.rb', 'spec/**/*.rb']
    end
  end

  def slim_lint
    @default_scripts << DSLConfig.new('slim_lint') do
      command 'bundle exec slim-lint app/views/ -c .slim-lint.yml'
      files ['app/views/**/*.slim']
      error_message '+slim-lint detected issues, commit aborted'
    end
  end

  def scss_lint
    @default_scripts << DSLConfig.new('scss_lint') do
      command 'scss-lint app/assets/stylesheets/**/*.scss'
      files ['app/assets/stylesheets/**/*.scss']
      error_message '+scss-lint detected issues, commit aborted'
    end
  end

  def tslint
    @default_scripts << DSLConfig.new('tslint') do
      command 'tslint -c tslint.json app/assets/javascripts/**/*.ts'
      files ['app/assets/javascripts/**/*.ts']
      error_message '+tslint detected issues, commit aborted'
    end
  end

  def coffeelint
    @default_scripts << DSLConfig.new('coffeelint') do
      command 'coffeelint -f .coffeelint.json app/assets/javascripts/**/*.coffee'
      files ['app/assets/javascripts/**/*.coffee']
      error_message '+coffeelint detected issues, commit aborted'
    end
  end

  def brakeman
    @default_scripts << DSLConfig.new('brakeman') do
      command 'bundle exec brakeman -q -z --summary > /dev/null'
      error_message '+Brakeman has detected one or more security vulnerabilities, please review them and re-commit ' \
                    'your changes, commit aborted'
    end
  end

  def reek
    @default_scripts << DSLConfig.new('reek') do
      command 'bundle exec reek'
      files ['app/**/*.rb']
      error_message '+reek detected code smells, commit aborted'
    end
  end

  def rspec
    @default_scripts << DSLConfig.new('rspec') do
      command 'bundle exec rspec'
      files ['app/**/*.rb', 'spec/**/*.rb', 'config/**/*', 'db/schema.rb']
    end
  end
end
# rubocop:enable Metrics/ClassLength
