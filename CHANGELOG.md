## unreleased 

Initial port of dry-system-rails with a couple of new features

### Added

- `:rails` system component provider, which uses standard bootable components, aka "features", to manage application state (@solnic)
- `config.features` setting which is an array with feature identifiers that you want the railtie to boot (@solnic)
- `:application_contract` feature which defines `ApplicationContract` within the application namespace and configured to work with `I18n` (@solnic)
- `:safe_params` feature which extends `ApplicationController` with `schema` DSL and exposes `safe_params` controller helper (@solnic)
