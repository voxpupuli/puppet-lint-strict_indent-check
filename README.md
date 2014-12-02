Installation
===

<pre>
gem install puppet-lint-strict_indent-check
</pre>

Usage
===

This plugin provides an indentation check for puppet-lint `strict_indent`. The check has a strict expectation for all indentation, except comments and whitespace/blank lines.

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

* indent should increase by one step the line after each opened brace (square, curly, paren)
* indent should decrease by one step the line of every closed brace.
* indent should increase by one step the line after a resource title, unless it already increased due to a bracket.
* indent should decrease by one step the line after the end of a resource due to semicolon, if it was indented for resource title.
* indent should decrease by one step the line of the end of a resource due to right curly brace, if it was indented for resource title, and not ended by a semicolon.
* indent should increase by one step the line after an equals `=` or farrow `=>` that ends a line, but only for that one line.

see `spec/fixtures/pass/` for good indentation examples.

see `spec/fixtures/fail/` for bad indentation examples.
