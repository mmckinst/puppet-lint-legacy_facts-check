[![Build Status](https://travis-ci.org/mmckinst/puppet-lint-legacy_facts-check.svg?branch=master)](https://travis-ci.org/mmckinst/puppet-lint-legacy_facts-check)
[![Gem](https://img.shields.io/gem/v/puppet-lint-legacy_facts-check.svg)](https://rubygems.org/gems/puppet-lint-legacy_facts-check)
[![Total Downloads](https://img.shields.io/gem/dt/puppet-lint-legacy_facts-check.svg)](https://rubygems.org/gems/puppet-lint-legacy_facts-check)
[![Latest Downloads](https://img.shields.io/gem/dtv/puppet-lint-legacy_facts-check.svg)](https://rubygems.org/gems/puppet-lint-legacy_facts-check)

## Overview

Puppet 3.5 [optionally added structured
facts](https://github.com/puppetlabs/docs-archive/blob/master/puppet/3.5/release_notes.markdown#structured-facts-early-version)
as well as the [global facts
hash](https://github.com/puppetlabs/docs-archive/blob/master/puppet/3.5/release_notes.markdown#global-facts-hash). They
were both turned on by default in puppet 4.

This linter will convert from legacy facts like `$::operatingsystem` or legacy
hashed facts like `$facts['operatingsystem']` to the new structured facts like
`$facts['os']['name']`.

If you only want to convert from facts like `$::operatingsystem` to the facts
hash like `$facts['operatingsystem']`, you want the [top scope facts
linter](https://github.com/mmckinst/puppet-lint-top_scope_facts-check).

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
$package_name = $facts['os']['name'] {
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

Alternatively, you can disable it directly in your puppet manifest.

```puppet
# lint:ignore:legacy_facts
$package_name = $facts['operatingsystem'] {
  'CentOS' => 'httpd',
  'Debian' => 'apache2',
}
# lint:endignore
```

## Limitations

The linter can only scan known facts in the codebase, custom facts cannot be scanned.

The linter will only find and work on top scope facts like `$::osfamily`,
non-top scope facts like `$osfamily` will not be found or fixed. 

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
