# Changelog

All notable changes to this project will be documented in this file.

## [4.0.0](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/4.0.0) (2025-08-06)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/3.0.0...4.0.0)

**Breaking changes:**

- Match the indent for a single semicolon with the Puppet documentation [\#48](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/48) ([msalway](https://github.com/msalway))
- Only indent once for doubled brackets [\#44](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/44) ([msalway](https://github.com/msalway))

**Fixed bugs:**

- Refactor heredoc indent calculations [\#47](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/47) ([msalway](https://github.com/msalway))

**Closed issues:**

- Ruby 3.1 test fails due to double start of SimpleCov [\#45](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/45)
- Test workflow fails [\#41](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/41)
- Extra indent requested with two opens on same line. [\#21](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/21)
- Update indent behaviour when semicolon is on a separate line [\#19](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/19)

**Merged pull requests:**

- Update README for recent changes [\#49](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/49) ([msalway](https://github.com/msalway))
- Remove SimpleCov.start as it is done by PuppetLint's spec\_helper [\#46](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/46) ([msalway](https://github.com/msalway))
- fix rubocop [\#42](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/42) ([paran1](https://github.com/paran1))
- Update voxpupuli-rubocop requirement from ~\> 1.1 to ~\> 2.0 [\#36](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/36) ([dependabot[bot]](https://github.com/apps/dependabot))

## [3.0.0](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/3.0.0) (2023-04-21)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/2.1.0...3.0.0)

**Breaking changes:**

- Drop Ruby \< 2.7; Add RuboCop [\#34](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/34) ([bastelfreak](https://github.com/bastelfreak))

## [2.1.0](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/2.1.0) (2022-11-29)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/2.0.8...2.1.0)

**Implemented enhancements:**

- puppet-lint: Allow 3.x [\#30](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/30) ([bastelfreak](https://github.com/bastelfreak))

## [2.0.8](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/2.0.8) (2021-07-25)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/2.0.7...2.0.8)

**Closed issues:**

- Bad behavior with UTF-8 chars [\#18](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/18)
- First line empty [\#16](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/16)

**Merged pull requests:**

- modulesync / add badges to README.md / cleanup gemspec [\#23](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/23) ([bastelfreak](https://github.com/bastelfreak))

## [2.0.7](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/2.0.7) (2019-02-07)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/2.0.6...2.0.7)

**Merged pull requests:**

- Fix issue with blank line at the beginning of a file. [\#17](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/17) ([phyber](https://github.com/phyber))

## [2.0.6](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/2.0.6) (2019-01-03)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/2.0.2...2.0.6)

**Closed issues:**

- Problem with heredoc strings [\#12](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/12)
- Incorrect indentation for hash as a function parameter [\#11](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/11)
- puppet-lint \>=2.0 [\#7](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/7)
- Reporting incorrect line number [\#5](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/5)

**Merged pull requests:**

- Run the test suite in Travis-CI [\#15](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/15) ([smortex](https://github.com/smortex))
- Add support for heredoc strings [\#14](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/14) ([smortex](https://github.com/smortex))
- Add simplecov as a development dependency [\#13](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/13) ([smortex](https://github.com/smortex))
- Reset not only whitespaces but comments too. [\#9](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/9) ([jiuka](https://github.com/jiuka))
- Support ruby 1.8.7 again [\#6](https://github.com/voxpupuli/puppet-lint-strict_indent-check/pull/6) ([Reamer](https://github.com/Reamer))

## [2.0.2](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/2.0.2) (2016-06-27)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/2.0.1...2.0.2)

**Closed issues:**

- Error fixing indent for variable in possion 0 [\#4](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/4)

## [2.0.1](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/2.0.1) (2014-12-02)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/2.0.0...2.0.1)

## [2.0.0](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/2.0.0) (2014-12-02)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/1.1.0...2.0.0)

**Closed issues:**

- Make expected indentation configurable [\#1](https://github.com/voxpupuli/puppet-lint-strict_indent-check/issues/1)

## [1.1.0](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/1.1.0) (2014-12-01)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/1.0.1...1.1.0)

## [1.0.1](https://github.com/voxpupuli/puppet-lint-strict_indent-check/tree/1.0.1) (2014-12-01)

[Full Changelog](https://github.com/voxpupuli/puppet-lint-strict_indent-check/compare/092d679f3cb0c4c6a14bffc99f0d39d51d4ac262...1.0.1)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
