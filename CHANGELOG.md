# Changelog

All notable changes to this project will be documented in this file.

---

## [0.1.1](https://github.com/eugene-ruby/rsodx/compare/v0.1.0...v0.1.1)  – 2025-05-15

### Added

* 💡 Introduced `Rsodx::Logger` – a flexible logging module with support for pluggable adapters.
* ✅ Added `Rsodx::LoggerAdapter` for wrapping any IO-compatible output (e.g. `$stdout`, `Syslog`, `File`).
* 🔧 Logger can now be configured via `Rsodx.configure { |c| c.logger = ... }`.
* 📦 Default logger writes to `$stdout` if no custom logger is provided.
* 🧰 Added support for `delegate ... prefix: true` in `Rsodx::Delegate`, similar to ActiveSupport behavior.

---

## [0.1.0](https://github.com/eugene-ruby/rsodx/compare/v0.0.3...v0.1.0) (2025-04-17)

### Features

* add rollback command ([ad47455](https://github.com/eugene-ruby/rsodx/commit/ad474550cbead91713e4c8c906ce0173e8a0434d))
* add rsodx console ([d13821a](https://github.com/eugene-ruby/rsodx/commit/d13821aeaabdba3d2d688253720b107d2be8a30a))


### Bug Fixes

* bd connect ([c240a48](https://github.com/eugene-ruby/rsodx/commit/c240a48b1c8a9226afdfe7cf35a16a08363bb3c2))
* handle missing environment.rb ([f3b54d3](https://github.com/eugene-ruby/rsodx/commit/f3b54d32853d131c2b83808758b569185e8ca162))
* initializers path with config ([3d11d2f](https://github.com/eugene-ruby/rsodx/commit/3d11d2f41455d178200223e6a13a597ccdb30a0a))

## [Unreleased]

- Add support for RabbitMQ pub/sub architecture
- Docker integration and `rsodx g docker`
- Swagger/OpenAPI generator based on DRY schemas
- Daemonized `rsodx server` with logging options

---
## [0.0.3] - 2025-04-15

### Changed
- Added minor stylistic improvements to CLI output (colors, emoji, formatting).
- Improved ASCII logo rendering and version display.
- Enhanced `bin/console` with better IRB context and `reload!` helper.

---

## [0.0.2] - 2025-04-15

### Changed

- Migrated CLI to `Dry::CLI` for clean and extensible command structure
- Replaced shell-based server launch with native Puma/Rack integration
- Standardized CLI interface: `rsodx generate`, `rsodx g`, `rsodx server`, `rsodx new`

### Added

- `rsodx g action` generates controller, serializer, and presenter
- Introduced new layered response pipeline:
    - `Controller → Serializer → Presenter`
    - With standardized DTO handling and JSON output via `Oj`

### Improved

- Internal code structure now fully `require_relative`-driven with inflector and alias support
- CLI alias mapping simplified via helper method

---

## [0.0.1] - 2025-04-13

- Initial release
- Project scaffolding: `rsodx new my_app`
- Basic structure with Rack, Sequel, app layout
