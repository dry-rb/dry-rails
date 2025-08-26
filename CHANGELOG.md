# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Break Versioning](https://www.taoensso.com/break-versioning).

## Unreleased


### Changed

- Update required Ruby version to 3.1 (@alassek)

## 0.7.0 2022-12-23


### Changed

- Bump dry-schema to `>= 0.13` (@solnic)
- Bump dry-validation to `>= 0.10` (@solnic)
- Bump dry-system to `~> 1.0` (@solnic)

[Compare v0.6.0...v0.7.0](https://github.com/dry-rb/dry-rails/compare/v0.6.0...v0.7.0)

## 0.6.0 2022-10-20


### Changed

- Upgrade to zeitwerkified dry-rb deps (issue #55 fixed via #56) (@solnic)

[Compare v0.5.0...v0.6.0](https://github.com/dry-rb/dry-rails/compare/v0.5.0...v0.6.0)

## 0.5.0 2022-02-11


### Changed

- dry-system dependency was bumped to >= 0.23 (via #52) (@solnic)

[Compare v0.4.0...v0.5.0](https://github.com/dry-rb/dry-rails/compare/v0.4.0...v0.5.0)

## 0.4.0 2021-12-23

This is a big update - please also read dry-system [CHANGELOG](https://github.com/dry-rb/dry-system/blob/master/CHANGELOG.md) versions 0.20 and 0.21.

### Added

- It's now possible to configure container constant name via `config.constainer_const_name` (issue #21 closed via #41) (@diegotoral)

### Fixed

- `config.auto_inject_constant` is now cleared during code reloading (see #40 for more info) (@diegotoral)

### Changed

- Updated to work with dry-system 0.21 (via #48 and #50) (@zlw + @solnic)
- dry-system dependency was bumped to >= 0.23 (via #52) (@solnic)

[Compare v0.3.0...v0.4.0](https://github.com/dry-rb/dry-rails/compare/v0.3.0...v0.4.0)

## 0.3.0 2020-08-26


### Changed

- Use dry-system 0.18.0 and configure new `bootable_dirs` setting appropriately (@timriley in #38)

[Compare v0.2.1...v0.3.0](https://github.com/dry-rb/dry-rails/compare/v0.2.1...v0.3.0)

## 0.2.1 2020-08-26


### Added

- Controller features now support `ActionControll::API` too (issue #35 closed via #36) (@rinaldifonseca)

### Fixed

- Fix dry-system dependency to 0.17.0, to avoid incompatibilities with 0.18.0 (@timriley)


[Compare v0.2.0...v0.2.1](https://github.com/dry-rb/dry-rails/compare/v0.2.0...v0.2.1)

## 0.2.0 2020-07-21


### Added

- You can now configure auto_inject constant name via `config.auto_inject_constant` - previously it was hardcoded as `"Import"`, now it's configured as `"Deps"` by default (issue #18 closed via #29) (@diegotoral)

### Fixed

- Resolving `Container` constant looks it up only within the application namespace (see #22 for more information) (@jandudulski)
- [safe_params] defining multiple schemas works as expected (issue #23 fixed via 24) (@gotar)

### Changed

- The `:env` dry-system plugin is now enabled by default (fixes #28 via #30) (@solnic)

[Compare v0.1.0...v0.2.0](https://github.com/dry-rb/dry-rails/compare/v0.1.0...v0.2.0)

## 0.1.0 2020-03-30

This is based on dry-system-rails that dry-rails replaces.

### Added

- `config.features` setting which is an array with feature identifiers that you want the railtie to boot (@solnic)
- `:application_contract` feature which defines `ApplicationContract` within the application namespace and configured to work with `I18n` (@solnic)
- `:safe_params` feature which extends `ApplicationController` with `schema` DSL and exposes `safe_params` controller helper (@solnic)
- `:controller_helpers` feature which adds `ApplicationController#{resolve,container}` shortcuts (@solnic)
