#!/bin/zsh

source ~/.zshrc

bundle exec rubocop -D -c .rubocop.yml --fail-fast
if [ ! $? -eq 0 ]; then
  echo 'rubocop detected issues!'
  bundle exec rubocop -a -D -c .rubocop.yml
  echo 'Tried to auto correct the issues, but must be reviewed manually, commit aborted'
  exit 1
fi
