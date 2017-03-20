## Version 0.0.0

First release after 10 days of planning and developing. Main functionality is implemented.
There is a known bug and it is not recommanded to use this version.

## Version 0.1.0

This release should make it possible to actually use the Gem:

* known Bugs are fixed

* New feature: Results can be reversed
  * mark the script you configure as reversed if you want
  * Output will be Error-Output
  * Error-Output will be Output
  * Exit code > 0 will be 0
  * Exit code 0 will be 1
  


## Version 0.2.0

In this release are more features implemented and the Gem is available in rubygems.org:

* gem is generated and available on rubygems.org

### New Features

* Output will be shown if the Error-Ouput is empty, even though the Script failed.
This was implemented as many Scripts use the Standard-Output for Outputs even if they fail.

* Standard-Output can be appended or overridden

* Error-Output can be appended or overridden

* Default-Script for faster Configuration of a bin/check in rails applications

## Version 0.2.1

* fixed typos
* refined readme

## Version 1.0.0.beta1

This release introduces a new fancy DSL (yeyy) which is easier to use and brings in much more possibilities

### New Features

* New DSL is implemented (old one still works for now, but the following features only work with the new one.)

* Common Configuration for multiple checks

* Defaults are available and can be used

* Possibility to exclude specific checks of a default

## Version 1.0.0.beta2

Fix mistakes in Default Scripts:
* Rubocop autocorrect fails if any issues are found, even if they can be autocorrected.
* Rspec wont use the cache, if the Gemfile.lock has changed.
* Rubocop wont use the cache, if any file from `config/**/*.rb` has changed.
