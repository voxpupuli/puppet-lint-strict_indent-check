Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-indent-check'
  spec.version     = '1.1.0'
  spec.homepage    = 'https://github.com/relud/puppet-lint-indent-check'
  spec.license     = 'Mozilla 2.0'
  spec.author      = 'Daniel Thornton'
  spec.email       = 'daniel@relud.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'puppet-lint indent check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure that you manifests have good indentation.
  EOF

  spec.add_dependency             'puppet-lint', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
end
