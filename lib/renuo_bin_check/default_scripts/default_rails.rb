module RenuoBinCheck
  # rubocop:disable Metrics/ModuleLength
  module DefaultScripts
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    # :reek:TooManyStatements
    def rails
      bin_check = RenuoBinCheck::Initializer.new

      mini_profiler(bin_check)
      todo(bin_check)
      console_log(bin_check)
      puts_without_brackets(bin_check)
      puts_with_brackets(bin_check)
      pp_and_p(bin_check)
      p_with_brackets(bin_check)
      rubocop_autocorrect(bin_check)
      slim_lint(bin_check)
      scss_lint(bin_check)
      tslint(bin_check)
      brakeman(bin_check)
      reek(bin_check)
      rspec(bin_check)

      bin_check.run
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def mini_profiler(bin_check)
      bin_check.check do |config|
        config.command "grep 'rack-mini-profiler' Gemfile.lock >> /dev/null"
        config.reversed_exit true
        config.files ['Gemfile.lock']
      end
    end

    def todo(bin_check)
      bin_check.check do |config|
        config.command "grep --exclude-dir='app/assets/typings/**' -i -r 'TODO' app spec config db Rakefile README.md"\
        ' Gemfile'
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*', 'config/**/*', 'db/**/*', 'Rakefile', 'README.md', 'Gemfile']
      end
    end

    def console_log(bin_check)
      bin_check.check do |config|
        config.command "grep -i -r 'console.log' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end
    end

    def puts_without_brackets(bin_check)
      bin_check.check do |config|
        config.command "grep -i -r '  puts ' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end
    end

    def puts_with_brackets(bin_check)
      bin_check.check do |config|
        config.command "grep -i -r '  puts(' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end
    end

    def pp_and_p(bin_check)
      bin_check.check do |config|
        config.command "grep -i -r '(  pp? [^=])|(= pp? )' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end
    end

    def p_with_brackets(bin_check)
      bin_check.check do |config|
        config.command "grep -i -r '  p(' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end
    end

    def rubocop_autocorrect(bin_check)
      bin_check.check do |config|
        config.command 'bundle exec rubocop -a -D -c .rubocop.yml'
        config.files ['app/**/*.rb', 'spec/**/*.rb']
      end
    end

    def slim_lint(bin_check)
      bin_check.check do |config|
        config.command 'bundle exec slim-lint app/views/ -c .slim-lint.yml'
        config.files ['app/views/**/*.slim']
      end
    end

    def scss_lint(bin_check)
      bin_check.check do |config|
        config.command 'scss-lint app/assets/stylesheets/**/*.scss'
        config.files ['app/assets/stylesheets/**/*.scss']
      end
    end

    def tslint(bin_check)
      bin_check.check do |config|
        config.command 'tslint -c tslint.json app/assets/javascripts/**/*.ts'
        config.files ['app/**/*.ts']
      end
    end

    def coffeelint(bin_check)
      bin_check.check do |config|
        config.command 'coffeelint -f .coffeelint.json app/assets/javascripts/**/*.coffee'
        config.files ['app/assets/javascripts/**/*.coffee']
      end
    end

    def brakeman(bin_check)
      bin_check.check do |config|
        config.command 'bundle exec brakeman -q -z --summary > /dev/null'
      end
    end

    def reek(bin_check)
      bin_check.check do |config|
        config.command 'bundle exec reek'
        config.files ['app/**/*.rb', 'spec/**/*.rb', 'config/**/*', 'db/**/*.rb', 'lib/**/*.rb', 'lib/**/*.rake',
                      'lib/**/*.rake', 'Gemfile*', '.reek']
      end
    end

    def rspec(bin_check)
      bin_check.check do |config|
        config.command 'bundle exec rspec'
        config.files ['app/**/*.rb', 'spec/**/*.rb', 'config/**/*', 'db/**/*.rb', 'lib/**/*.rb', 'lib/**/*.rake',
                      'lib/**/*.rake', 'Gemfile', 'Gemfile.lock', '.rspec']
      end
    end

    module_function :rails
    module_function :mini_profiler
    module_function :todo
    module_function :console_log
    module_function :puts_without_brackets
    module_function :puts_with_brackets
    module_function :pp_and_p
    module_function :p_with_brackets
    module_function :rubocop_autocorrect
    module_function :slim_lint
    module_function :scss_lint
    module_function :tslint
    module_function :coffeelint
    module_function :brakeman
    module_function :reek
    module_function :rspec
  end
  # rubocop:enable Metrics/ModuleLength
end
