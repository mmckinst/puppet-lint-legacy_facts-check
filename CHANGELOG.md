1.0.3 - 2020-01-27
---
* work around for https://github.com/mmckinst/puppet-lint-legacy_facts-check/pull/28
* drop ruby 1.9.3 support

1.0.2 - 2019-05-26
---
* fix a warning from https://github.com/mmckinst/puppet-lint-legacy_facts-check/pull/24

1.0.1 - 2019-05-02
---
* fix incorrectly mapped facts in https://github.com/mmckinst/puppet-lint-legacy_facts-check/issues/21

1.0.0 - 2019-04-12
---
* fix variables in double quoted strings https://github.com/mmckinst/puppet-lint-legacy_facts-check/issues/15
* release 1.0.0 because the gem is stable and fixing variables in double quoted
  strings will find more puppet-lint issues on code that was falsely believed to
  have no puppet-lint issues.

0.0.6 - 2019-01-10
---
* document the linter only works on top scope facts
* fix and update links to facter documentation
* add comments to code

0.0.5 - 2018-11-27
---
* fix correction of facts contained in strings in https://github.com/mmckinst/puppet-lint-legacy_facts-check/pull/13

0.0.4 - 2018-11-12
---
* fix ssh key regex in https://github.com/mmckinst/puppet-lint-legacy_facts-check/pull/10
* add ruby 2.4 support in https://github.com/mmckinst/puppet-lint-legacy_facts-check/pull/9

0.0.3 - 2017-03-06
---
* fix error messages in https://github.com/mmckinst/puppet-lint-legacy_facts-check/issues/6 and https://github.com/mmckinst/puppet-lint-legacy_facts-check/pull/7

0.0.2 - 2016-08-22
---
* code improvements

0.0.1 - 2016-08-20
---
* initial release
