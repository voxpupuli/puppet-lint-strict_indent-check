# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'puppet-lint-strict_indent-check'
  spec.version     = '5.0.0'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-strict_indent-check'
  spec.license     = 'MPL-2.0'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
    'CHANGELOG.md',
  ]
  spec.summary     = 'puppet-lint strict indent check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure that your manifests follow a strict indentation pattern.
  EOF

  spec.required_ruby_version = '>= 3.2'

  spec.add_dependency 'puppet-lint', '~> 5.1'
end
