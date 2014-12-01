Installation
===

<pre>
gem install puppet-lint-indent-check
</pre>

Usage
===

This plugin provides an indentation check for puppet-lint `indent`. The check has a strict expectation for all indentation, except comments and whitespace/blank lines.

supports --fix flag

Check will raise a warning for any files that don't have 2-space indent, and follow specific guidelines for increase/decrease of indent.

Alternate Indentation
===

Indentation defaults to 2 spaces. To use a different number of spaces, use the `-l` option to load ruby file changing the `chars_per_indent` config.

config file `chars_per_indent_4.rb`:
<pre>
# This could also be set in your Rakefile
PuppetLint.configuration.chars_per_indent = 4
</pre>

lint command:
<pre>
puppet-lint -l chars_per_indent_4.rb puppet-mysql/manifests/init.pp
</pre>

Acceptable Identation
===

see `spec/fixtures/pass/` for good indentation examples
see `spec/fixtures/fail/` for bad indentation examples
