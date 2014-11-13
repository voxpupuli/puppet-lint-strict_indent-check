Installation
===

Usage
===
This plugin provides an indentation check for puppet-lint `indent`. The check has a strict expectation for all indentation, except comments and whitespace/blank lines.

supports --fix flag

Check will raise a warning for any files that don't have 2-space indent, and follow specific guidelines for increase/decrease of indent.

Acceptable Identation
===

<pre>
class (
  $foo = 'foo',
  $bar =
    'this string is too damn long to fit in a regular 80 char line parameter',
  $baz = [
    'a',
    [
      'b',
    ],
    'c',
  ],
) {
  file { '/abc':
    ensure  => 'file',
    content => file('mymodule/abc'),
  }

  package {
    'abc':
      ensure => 'present';

    [
      'def',
      'ghi',
    ]:
      ensure => 'absent';
  }
}
</pre>
