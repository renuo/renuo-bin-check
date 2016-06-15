[![Build Status](https://travis-ci.org/renuo/renuo-bin-check.svg?branch=master)](https://travis-ci.org/renuo/renuo-bin-check) [![Build Status](https://travis-ci.org/renuo/renuo-bin-check.svg?branch=develop)](https://travis-ci.org/renuo/renuo-bin-check)  [![Build Status](https://travis-ci.org/renuo/renuo-bin-check.svg?branch=testing)](https://travis-ci.org/renuo/renuo-bin-check) [![Code Climate](https://codeclimate.com/github/renuo/renuo-bin-check/badges/gpa.svg)](https://codeclimate.com/github/renuo/renuo-bin-check) [![Issue Count](https://codeclimate.com/github/renuo/renuo-bin-check/badges/issue_count.svg)](https://codeclimate.com/github/renuo/renuo-bin-check) [![Test Coverage](https://codeclimate.com/github/renuo/renuo-bin-check/badges/coverage.svg)](https://codeclimate.com/github/renuo/renuo-bin-check/coverage)
# renuo-bin-check

## Setup

```
git clone git@github.com:renuo/renuo-bin-check.git
cd renuo-bin-check
bin/setup
```

## Run Tests

The following script will run rspec, rubocop, reek, scanner for debugging outputs and a scanner for TODOs

```
bin/check
```

Run automated tests only with: `rspec`

Run Lining only: `rubocop`

Run Code Smell detector only: `reek``

## How To Use renuo-bin-check

Install renuo-bin-check locally: see Setup

Add renuo-bin-check to your Gemfile:

```rb
gem 'renuo-bin-check', path: '<path-to-renuo-bin-check>'
```

Create a file at any place you want. Usually it would be called bin/check though.

You can now configure your scripts like that:

```rb
# Include all ruby files of renuo-bin-check
Dir["<path-to-renuo-bin-check>/lib/renuo_bin_check/*.rb"].each { |file| require file }

# Initialize bin-check
bin_check = RenuoBinCheck::Initializer.new

# add a script, do this for as many scripts as you would like to run
bin_check.check do |config|
  config.command "<a one line command or a path to a script>"
  config.name "<name-of-script>"
  config.files ['<path-to-file-1>', '<path-to-file-2>']
  config.reversed_exit <true or false>
end

#run everything
bin_check.run
```

### Options

#### command

This option is required. It is either a one-liner such as `ls -al` or a path to a script, that will be runned.
If command is not configured, the program will raise a RuntimeError.

#### name

This option is optional. It makes it possible to configure the name of the script. 
It will be used as folder name in the cache.

If it is not set, the hashed command will be used as folder name in the cache.

Attention: If you set the same name twice, it won't raise an error, 
but it can cause unexpected behaviour, hence it is not recommanded to do so.

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

### Example

The following example configures a script that looks for TODOs in a project.
The configuration options can be called in any order.

```rb
bin_check.check do |config|
  config.command "grep --exclude-dir='app/assets/typings/**' -i -r 'TODO'"\
                  "app spec config db Rakefile README.md Gemfile"
  config.name "todo-grepper"
  config.files ['app/**/*', 'spec/**/*', 'config/**/*', 'db/**/*', 'Rakefile', 'README.md', 'Gemfile']
  config.success_message "No TODO was found :)"
  config.error_message "+TODO found! Please get rid of them"
  config.reversed_exit true
end
```

## Contribute

If you would like to contribute, you're very welcome to.

Please follow these instructions:

https://github.com/renuo/renuo-bin-check/blob/develop/CONTRIBUTING.md

https://github.com/renuo/renuo-bin-check/blob/develop/CODE_OF_CONDUCT.md

## License

Copyright (c) 2016 Renuo GmbH

MIT License

Read more: https://github.com/renuo/renuo-bin-check/blob/develop/LICENSE
