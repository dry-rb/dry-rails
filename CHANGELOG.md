# v0.3.0 2019-09-29

### Changed

- Depend on dry-system 0.12.x (arielvalentin)
- Drop support for Ruby versions earlier than 2.4 (arielvalentin)
- Evaluate user-supplied `Dry::System::Rails.container { ... }` block before applying any standard behaviour (which includes accessing the container's config). This change makes it possible for the user to adjust the container's dry-configurable-provided settings, e.g. through using dry-system plugins that add their own settings (timriley)

[Compare v0.2.0...v0.3.0](https://github.com/dry-rb/dry-system/compare/v0.2.0...v0.3.0)

# v0.2.0 2019-04-16

### Added

- Support for code reloading in development environment (arielvalentin + solnic)

### Changed

- [BREAKING] Initializer interface is now `Dry::System::Rails.container { ... }` which simply captures the block
  to evaluate it in the context of the container class. This gives you full control over container creation (solnic)

# v0.1.0 2018-01-05

### Changed

* Upgraded to `dry-system` `v0.10.1`

# v0.0.2 2016-08-23

### Fixed

* `Railtie#namespace` has been renamed to `#app_namespace` because it may conflict with Rake's '#namespace' (blelump)

# v0.0.1 2016-08-17

First public release
