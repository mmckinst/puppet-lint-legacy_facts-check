[![Build Status](https://travis-ci.org/mmckinst/puppet-lint-legacy_facts-check.svg?branch=master)](https://travis-ci.org/mmckinst/puppet-lint-legacy_facts-check)
[![Gem](https://img.shields.io/gem/v/puppet-lint-legacy_facts-check.svg?maxAge=2592000)](https://rubygems.org/gems/puppet-lint-legacy_facts-check)
![](https://img.shields.io/gem/dtv/puppet-lint-legacy_facts-check.svg?style=flat)
![](https://img.shields.io/gem/dt/puppet-lint-legacy_facts-check.svg?style=flat)

## Overview

A pupet-lint to check you are not using legacy facts like `$::operatingsystem`
or `$facts['operatingsystem']`. You should use the new structured facts like
`$facts['os']['name']` instead

## Installing

### From the command line

```shell
$ gem install puppet-lint-legacy_facts-check
```

### In a Gemfile

```ruby
gem 'puppet-lint-legacy_facts-check', :require => false
```

## Checks

#### What you have done

```puppet
$package_name = $::operatingsystem {
  'CentOS' => 'httpd',
  'Debian' => 'apache2',
}
```

```puppet
$package_name = $facts['operatingsystem'] {
  'CentOS' => 'httpd',
  'Debian' => 'apache2',
}
```

#### What you should have done

```puppet
$service_name = $facts['os']['name'] {
  'CentOS' => 'httpd',
  'Debian' => 'apache2',
}
```

#### Disabling the check

To disable this check, you can add `--no-legacy_facts` to your puppet-lint
command line.

```shell
$ puppet-lint --no-legacy_facts path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should
insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_legacy_facts')
```

## Limitations

The linter will only find and work on top scope facts like `$::osfamily`,
non-top scope facts like `$osfamily` will not be found or fixed. The
[top_scope_facts-check ](https://github.com/mmckinst/puppet-lint-top_scope_facts-check)
puppet linter can be used to fix that problem

Some facts have no equivalent in the structured fact list:

### `memoryfree_mb`

There is no fact that returns exclusively in MiB.

The closest equivalent is `$facts['memory']['system'][available']` or
`$facts['memory']['system']['available_bytes']`.

See
[facter documentation on memory](https://puppet.com/docs/facter/3.12/core_facts.html#memory).

### `memorysize_mb`

There is no fact that returns exclusively in MiB.

The closest equivalent is `$facts['memory']['system']['total']` or
`$facts['memory']['system']['total_bytes']`.

See [facter documentation on memory](https://puppet.com/docs/facter/3.12/core_facts.html#memory).

### `swapfree_mb`

There is no fact that returns exclusively in MiB.

The closest equivalent is `$facts['memory']['swap']['available']` or
`$facts['memory']['swap']['available_bytes']`.

See [facter documentation on memory](https://puppet.com/docs/facter/3.12/core_facts.html#memory).

### `swapsize_mb`

There is no fact that returns exclusively in MiB.

The closest equivalent is `$facts['memory']['swap']['used']` or
`$facts['memory']['swap']['used_bytes']`.

See [facter documentation on memory](https://puppet.com/docs/facter/3.12/core_facts.html#memory).

### `blockdevices`

This returns a string containing all block devices separated by a comma.

This can be duplicated using
[puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib) and the
following: `join(keys($facts['disks']), ',')`

### `interfaces`

This returns a string containing all interfaces separated by a comma.

This can be duplicated using
[puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib) and the
following: `join(keys($facts['networking']['interfaces']), ',')`.

### `zones`

This returns a string containing all zone names separated by a comma.

This can be duplicated using
[puppetlabs/stdlib](https://github.com/puppetlabs/puppetlabs-stdlib) and the
following: `join(keys($facts['solaris_zones']['zones']), ',')`

### `sshfp_dsa`

This returns a string containing both the SHA1 and SHA256 fingerprint for the
DSA algorithm.

This can be duplicated using the following string:
`"$facts['ssh']['dsa']['fingerprints']['sha1']
$facts['ssh']['dsa']['fingerprints']['sha256']"`

### `sshfp_ecdsa`

This returns a string containing both the SHA1 and SHA256 fingerprint for the
ECDSA algorithm.

This can be duplicated using the following string:
`"$facts['ssh']['ecdsa']['fingerprints']['sha1']
$facts['ssh']['ecdsa']['fingerprints']['sha256']"`

### `sshfp_ed25519`

This returns a string containing both the SHA1 and SHA256 fingerprint for the
Ed25519 algorithm.

This can be duplicated using the following string:
`"$facts['ssh']['ed25519']['fingerprints']['sha1']
$facts['ssh']['ed25519']['fingerprints']['sha256']"`

### `sshfp_rsa`

This returns a string containing both the SHA1 and SHA256 fingerprint for the
RSA algorithm.

This can be duplicated using the following string:
`"$facts['ssh']['rsa']['fingerprints']['sha1']
$facts['ssh']['rsa']['fingerprints']['sha256']"`

## License

```
Copyright 2016 Mark McKinstry

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
