#!/usr/bin/env zsh
#
# ZSH plugin for the Homebrew Package Manager
#
# Copyright (c) 2019 Alexander Wolff <wolffaxn[at]gmail[dot]com>
#

if ! (( $+commands[brew] )); then
  print "zsh brew plugin: brew not found. Please install homebrew before using this plugin." >&2
  return 1
fi

brew() {
  case "$1" in
  cleanup)
    (cd "$(brew --repo)" && git prune && git gc)
    command brew cleanup
    rm -rf "$(brew --cache)"
    ;;
  repair)
    (cd "$(brew --repo)" && git fetch && git reset --hard origin/master)
    brew update
    ;;
  update)
    command brew update
    command brew upgrade
    brew cleanup
    ;;
  *)
    command brew "$@"
    ;;
  esac
}

# hashes for easier cd'ing
# example: cd ~casks
hash -d brew_repo="$(brew --repo)"
hash -d brew_cache="$(brew --cache)"
hash -d casks="$(brew --prefix)/Caskroom"
hash -d cellar="$(brew --cellar)"
hash -d taps="$(brew --prefix)/Homebrew/Library/Taps"
