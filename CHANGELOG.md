# v0.2.0 to-be-released

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
