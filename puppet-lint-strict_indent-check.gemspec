Gem::Specification.new do |spec|
  spec.name = 'puppet-lint-strict_indent-check'
  spec.version     = '2.1.0'
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

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'puppet-lint', '>= 3', '< 5'
end
