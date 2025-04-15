# Changelog

All notable changes to this project will be documented in this file.

---

## [Unreleased]

- Add support for RabbitMQ pub/sub architecture
- Docker integration and `rsodx g docker`
- Swagger/OpenAPI generator based on DRY schemas
- Daemonized `rsodx server` with logging options

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
