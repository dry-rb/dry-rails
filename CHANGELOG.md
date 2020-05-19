## unreleased 


### Added

- You can now configure auto_inject constant name via `config.auto_inject_constant` - previously it was hardcoded as `"Import"`, now it's configured as `"Deps"` by default (issue #18 closed via #29) (@diegotoral)

### Fixed

- Resolving `Container` constant looks it up only within the application namespace (see #22 for more information) (@jandudulski)
- [safe_params] defining multiple schemas works as expected (issue #23 fixed via 24) (@gotar)

### Changed

- The `:env` dry-system plugin is now enabled by default (fixes #28 via #30) (@solnic)

[Compare v0.1.0...master](https://github.com/dry-rb/dry-rails/compare/v0.1.0...master)

## 0.1.0 2020-03-30

This is based on dry-system-rails that dry-rails replaces.

### Added

- `config.features` setting which is an array with feature identifiers that you want the railtie to boot (@solnic)
- `:application_contract` feature which defines `ApplicationContract` within the application namespace and configured to work with `I18n` (@solnic)
- `:safe_params` feature which extends `ApplicationController` with `schema` DSL and exposes `safe_params` controller helper (@solnic)
- `:controller_helpers` feature which adds `ApplicationController#{resolve,container}` shortcuts (@solnic)
