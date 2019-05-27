Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-legacy_facts-check'
  spec.version     = '1.0.2'
  spec.homepage    = 'https://github.com/mmckinst/puppet-lint-legacy_facts-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Mark McKinstry'
  spec.email       = 'mmckinst@umich.edu'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'A puppet-lint plugin to check you are not using legacy facts like $::operatingsystem'
  spec.description = <<-EOF
  A pupet-lint to check you are not using legacy facts like `$::operatingsystem`
  or `$facts['operatingsystem']`. You should use the new structured facts like
  `$facts['os']['name']` instead
  EOF

  spec.add_dependency             'puppet-lint', '~> 2.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-json_expectations'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'simplecov'
end
