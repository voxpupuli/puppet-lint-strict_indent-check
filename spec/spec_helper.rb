require 'simplecov'
SimpleCov.start

require 'puppet-lint'

PuppetLint::Plugins.load_spec_helper
