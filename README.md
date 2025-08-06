# Installation

[![License](https://img.shields.io/github/license/voxpupuli/puppet-lint-strict_indent-check.svg)](https://github.com/voxpupuli/puppet-lint-strict_indent-check/blob/master/LICENSE)
[![Test](https://github.com/voxpupuli/puppet-lint-strict_indent-check/actions/workflows/test.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-strict_indent-check/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/voxpupuli/puppet-lint-strict_indent-check/branch/master/graph/badge.svg?token=Mypkl78hvK)](https://codecov.io/gh/voxpupuli/puppet-lint-strict_indent-check)
[![Release](https://github.com/voxpupuli/puppet-lint-strict_indent-check/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-strict_indent-check/actions/workflows/release.yml)
[![RubyGem Version](https://img.shields.io/gem/v/puppet-lint-strict_indent-check.svg)](https://rubygems.org/gems/puppet-lint-strict_indent-check)
[![RubyGem Downloads](https://img.shields.io/gem/dt/puppet-lint-strict_indent-check.svg)](https://rubygems.org/gems/puppet-lint-strict_indent-check)
[![Donated by Daniel Thorn](https://img.shields.io/badge/donated%20by-Daniel%20Thorn-fb7047.svg)](#transfer-notice)

A puppet-lint plugin to validate Puppet DSL indentation

## Usage

This plugin provides an indentation check for puppet-lint `strict_indent`. The check has a strict expectation for all indentation, except comments and whitespace/blank lines.

supports --fix flag

Check will raise a warning for any files that don't have 2-space indent, and follow specific guidelines for increase/decrease of indent.

## Alternate Indentation

Indentation defaults to 2 spaces. To use a different number of spaces, use the `-l` option to load ruby file changing the `chars_per_indent` config.

config file `chars_per_indent_4.rb`:
```
# This could also be set in your Rakefile
PuppetLint.configuration.chars_per_indent = 4
```

lint command:
```
puppet-lint -l chars_per_indent_4.rb puppet-mysql/manifests/init.pp
```

## Acceptable Identation

* indent should increase by one step the line after each opened brace (square, curly, paren).
* indent should decrease by one step the line of every closed brace.
* if multiple pairs of braces are opened and closed on the same two lines the indent should only increase once.
* indent should increase by one step the line after a resource title, unless it already increased due to a bracket.
* indent should decrease by one step the line after the end of a resource due to semicolon, if it was indented for resource title.
* if the semicolon is the only element on the line then the indent decreases on the semicolon line instead of the line after.
* indent should decrease by one step the line of the end of a resource due to right curly brace, if it was indented for resource title, and not ended by a semicolon.
* indent should increase by one step the line after an equals `=` or farrow `=>` that ends a line, but only for that one line.
* heredoc contents should be indented by one step.

see `spec/fixtures/pass/` for good indentation examples.

see `spec/fixtures/fail/` for bad indentation examples.

## Transfer Notice

This plugin was originally authored by [Daniel Thorn](https://github.com/relud).
The maintainer preferred that Vox Pupuli take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute at https://github.com/voxpupuli/puppet-lint-strict_indent-check.

Previously: https://github.com/relud/puppet-lint-strict_indent-check

## License

This gem is licensed under the Mozilla Public license 2.


## Release information

To make a new release, please do:
* update the version in the gemspec file
* Install gems with `bundle install --with release --path .vendor`
* generate the changelog with `bundle exec rake changelog`
* Check if the new version matches the closed issues/PRs in the changelog
* Create a PR with it
* After it got merged, push a tag. GitHub actions will do the actual release to rubygems and GitHub Packages
