Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-strict_indent-check'
  spec.version     = '2.0.7'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-strict_indent-check'
  spec.license     = 'Mozilla 2.0'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'puppet-lint strict indent check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure that your manifests follow a strict indentation pattern.
  EOF

  spec.add_dependency             'puppet-lint', '> 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rspec-json_expectations'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
end
