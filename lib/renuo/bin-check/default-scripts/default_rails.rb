module RenuoBinCheck
  module DefaultScripts
    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    # :reek:DuplicateMethodCall
    # :reek:TooManyStatements
    def rails
      bin_check = RenuoBinCheck::Initializer.new

      bin_check.check do |config|
        config.command "grep 'rack-mini-profiler' Gemfile.lock >> /dev/null"
        config.reversed_exit true
        config.files ['Gemfile.lock']
      end

      bin_check.check do |config|
        config.command "grep --exclude-dir='app/assets/typings/**' -i -r 'TODO' app spec config db Rakefile README.md"\
        ' Gemfile'
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*', 'config/**/*', 'db/**/*', 'Rakefile', 'README.md', 'Gemfile']
      end

      bin_check.check do |config|
        config.command "grep -i -r 'console.log' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end

      bin_check.check do |config|
        config.command "grep -i -r '  puts ' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end

      bin_check.check do |config|
        config.command "grep -i -r '  puts(' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end

      bin_check.check do |config|
        config.command "grep -i -r '(  pp? [^=])|(= pp? )' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end

      bin_check.check do |config|
        config.command "grep -i -r '  p(' app spec"
        config.reversed_exit true
        config.files ['app/**/*', 'spec/**/*']
      end

      bin_check.check do |config|
        config.command 'bundle exec rubocop -a -D -c .rubocop.yml'
        config.files ['app/**/*.rb', 'spec/**/*.rb']
      end

      bin_check.check do |config|
        config.command 'bundle exec slim-lint app/views/ -c .slim-lint.yml'
        config.files ['app/views/**/*.slim']
      end

      bin_check.check do |config|
        config.command 'scss-lint app/assets/stylesheets/**/*.scss'
        config.files ['app/assets/stylesheets/**/*.scss']
      end

      bin_check.check do |config|
        config.command 'scss-lint app/assets/stylesheets/**/*.scss'
        config.files ['app/assets/stylesheets/**/*.scss']
      end

      bin_check.check do |config|
        config.command 'tslint -c tslint.json app/assets/javascripts/**/*.ts'
        config.files ['app/assets/javascripts/**/*.ts']
      end

      # bin_check.check do |config|
      #   config.command 'coffeelint -f .coffeelint.json app/assets/javascripts/**/*.coffee'
      #   config.files ['app/assets/javascripts/**/*.coffee']
      # end

      bin_check.check do |config|
        config.command 'bundle exec brakeman -q -z --summary > /dev/null'
      end

      bin_check.check do |config|
        config.command 'bundle exec reek'
        config.files ['app/**/*.rb']
      end

      bin_check.check do |config|
        config.command 'bundle exec reek'
        config.files ['app/**/*.rb']
      end

      bin_check.check do |config|
        config.command 'bundle exec rspec'
        config.files ['app/**/*.rb', 'spec/**/*.rb']
      end

      bin_check.run
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    module_function :rails
  end
end
