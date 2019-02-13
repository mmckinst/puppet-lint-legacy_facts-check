require 'puppet-lint'

PuppetLint::Plugins.load_spec_helper

RSpec.configure do |config|
  config.formatter = :documentation
end
