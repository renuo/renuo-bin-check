[![Build Status](https://travis-ci.org/renuo/renuo-bin-check.svg?branch=master)](https://travis-ci.org/renuo/renuo-bin-check) [![Build Status](https://travis-ci.org/renuo/renuo-bin-check.svg?branch=develop)](https://travis-ci.org/renuo/renuo-bin-check)  [![Build Status](https://travis-ci.org/renuo/renuo-bin-check.svg?branch=testing)](https://travis-ci.org/renuo/renuo-bin-check) [![Code Climate](https://codeclimate.com/github/renuo/renuo-bin-check/badges/gpa.svg)](https://codeclimate.com/github/renuo/renuo-bin-check) [![Issue Count](https://codeclimate.com/github/renuo/renuo-bin-check/badges/issue_count.svg)](https://codeclimate.com/github/renuo/renuo-bin-check) [![Test Coverage](https://codeclimate.com/github/renuo/renuo-bin-check/badges/coverage.svg)](https://codeclimate.com/github/renuo/renuo-bin-check/coverage)

# renuo-bin-check

With this gem you can automatically check your code quality (e.g. before every commit).
You can configure it to run [*rubocop*][1], [*reek*](2), [*rspec*](3) and even custom scripts.
For faster runtime it makes use of caching and parallel execution.

## How To Use renuo-bin-check

Add renuo-bin-check to your Gemfile:

```rb
gem 'renuo-bin-check', group: :bin_check
```

Create a file at any place you want. Usually it would be called `bin/check though.
You can now configure your checks like that:

```rb
#require renuo_bin_check in your file
require 'bundler/setup'
Bundler.require(:bin_check)

# run bin-check with rails-defaults
BinCheck.run do
  #add a new check
  <name_of_check> do
    command "<a one line command or a path to a script>"
    files ['<path-to-file-1>', '<path-to-file-2>']
    reversed_exit <true or false>
    success_message '<output to display if script succeeds>'
    error_message '<output to display if script fails>'
  end
  
  #exclude a default check
  exclude :<name-of-default-check>
end

```

It is also possible to have common configurations and to not run the rails-defaults:

```rb
#run bin without defaults
BinCheck.run :no_defaults do
  # define common settings for all checks in the block
  <name_of_your_common_configuration> do
    reversed_exit <true or false>
    success_message '<output to display if script succeeds>'
    error_message '<output to display if script fails>'
    
    # add check
    <name_of_check> do
        # add specific settings for this check
        command "<a one line command or a path to a script>"
        files ['<path-to-file-1>', '<path-to-file-2>']
        # override common settings
        reversed_exit <true or false>
      end
  end
end
```

## Setup

    git clone git@github.com:renuo/renuo-bin-check.git
    cd renuo-bin-check
    bin/setup


## Run Tests

The following script will run *rspec*, *rubocop*, *reek*, scanner for debugging outputs and a scanner for TODOs

    bin/check


### Options for Configuration

#### command

This option is required. It is either a one-liner such as `ls -al` or a path to a script, that will be runned.
If command is not configured, the program will raise a RuntimeError.

#### files

This option is optional. If configured the script output will be cached. You need to list all files in array form, 
which influence the outcome of the configured script.

Even though this option is optional, it is recommended to set it, as it can make a run much faster.

#### success_message

This option is optional. You can use it to override the standard output of a script or to append a further output.

If you want to override it just write the message, that you want to be shown. If you want to append a message, start
your message with a ```+```.

#### error_message

This option is optional. You can use it to override the error output of a script or to append a further output.

If you want to override it just write the message, that you want to be shown. If you want to append a message, start
your message with a ```+```.

#### reversed_exit

This option is optional. You can set it truthy or falsey. if not set it's automatically set falsey.

If set to truthy, the output of the configured script will be reversed. Which means:
* Error-Outputs will be Outputs
* Outputs will be Error-Output
* Exit Code of 0 will be 1
* Exit Code of not-0 will be 0

An example where this option is used, is the command that searches for TODOs. 
The script should fail though if something is found and not if nothing is found.

### Defaults

For using renuo-bin-check for checking rails applications we have defaults the following defaults:

Usage of defaults:

```
# use defaults, or don't use any by using :no-defaults
BinCheck.run :<name-of-default> {}
```

Excluding specific checks from defaults example:

```
BinCheck.run :rails_coffee_script_defaults do
  exclude :todo
  exclude :reek
end
```

#### rails_defaults (will be used if no default is given)

It includes following checks:
* todo (searches for todos in the code)
* console_log (searches for console_log in the code)
* puts_with_brackets  (searches for puts( in the code)
* puts_without_brackets (searches for puts in the code)
* pp_and_p  (searches for p and pp in the code)
* p_with_brackets (searches for p( in the code)
* rubocop_autocorrect (runs rubocop with autocorrection)
* slim_lint (runs slim_lint)
* scss_lint (runs scss_lint ATTENTION: THIS DOESN'T WORK YET)
* tslint  (runs tslint)
* brakeman (runs brakeman)
* reek (runs reek ATTENTION: THIS DOESN'T WORK YET)
* rspec (runs rspec)

#### rails_coffee_script_defaults

It includes following checks:
* todo (searches for todos in the code)
* console_log (searches for console_log in the code)
* puts_with_brackets  (searches for puts( in the code)
* puts_without_brackets (searches for puts in the code)
* pp_and_p  (searches for p and pp in the code)
* p_with_brackets (searches for p( in the code)
* rubocop_autocorrect (runs rubocop with autocorrection)
* slim_lint (runs slim_lint)
* scss_lint (runs scss_lint ATTENTION: THIS DOESN'T WORK YET)
* coffeelint  (runs coffeelint ATTENTION: THIS ISN'T TESTED YET)
* brakeman (runs brakeman)
* reek (runs reek ATTENTION: THIS DOESN'T WORK YET)
* rspec (runs rspec)

### Example

The following example configures a script that looks for TODOs in a project.
The configuration options can be called in any order.

```rb
BinCheck do
  todo_grepper do
    command "grep --exclude-dir='app/assets/typings/**' -i -r 'TODO'"\
                    "app spec config db Rakefile README.md Gemfile"
    files ['app/**/*', 'spec/**/*', 'config/**/*', 'db/**/*', 'Rakefile', 'README.md', 'Gemfile']
    success_message "No TODO was found :)"
    error_message "+TODO found! Please get rid of them"
    reversed_exit true
  end
end
```

## Known Bugs

* scss-lint doesnt work yet with renuo-bin-check
* reek doesnt work yet with renuo-bin-check

## Contribute

If you would like to contribute, you're very welcome to.

Please follow these instructions:

* [Contributing][4]
* [Code of Conduct][5]

## License

Copyright (c) 2016 [Renuo AG]

[MIT License][6]


[1]: https://github.com/bbatsov/rubocop
[2]: https://github.com/troessner/reek
[3]: https://github.com/rspec/rspec

[4]: https://github.com/renuo/renuo-bin-check/blob/develop/CONTRIBUTING.md
[5]: https://github.com/renuo/renuo-bin-check/blob/develop/CODE_OF_CONDUCT.md
[6]: https://github.com/renuo/renuo-bin-check/blob/develop/LICENSE

[Renuo AG]: https://www.renuo.ch
