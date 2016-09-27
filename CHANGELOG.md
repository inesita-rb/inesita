## [0.4.3] - 2016.09.27

### Added
- `on_enter` callback to Router

### Fixed
- sprockets deprecation warning


## [0.4.1] - 2016.07.15

### Added
- nice changelog

### Changed
- update `opal` to `0.10.0`

### Removed
- deprecated `update_dom`

### Fixed
- prefix bug in opal 0.10

## [0.4.0] - 2016.05.02

### Added
- `router` is accessible from `store`
- `init` callback to `Store` and `Component`
- `Inesita::Browser` minimal browser support
- `router` support `*param` to catch rest of url
- `virtual-dom` hooks (instead of `after_render`)

### Changed
- rename `Router#handle_link` to `Router#go_to`

### Removed
- `Component#after_render`
- `opal-browser` is now optional
- extract livereload to `inesita-livereload`


## [0.3.5] - 2016.03.10
- add `inesita watch`
- add `inesita build` dir parameters


## [0.3.2] - 2016-03-05

### Added
- add `app_dist` and `app_dev` directory support
- add `redirect_to` to `route` options


## [0.3.1] - 2016-01-05

### Added
- `class_names` helper
- params hash in `Router#url_for`

### Fixed
- fix `router.current_url?`


## [0.3.0] - 2015-12-20

### Added
- live-reload
- `after_render` component method - executes after component is rendered
- specs
- static support - for serving images
- minification support

### Changed
- rename `update_dom` to `render!`
- use `opal-browser` instead of pure javascript

[Unreleased]: https://github.com/inesita-rb/inesita/compare/v0.4.3...HEAD
[0.4.3]: https://github.com/inesita-rb/inesita/compare/v0.4.1...v0.4.3
[0.4.1]: https://github.com/inesita-rb/inesita/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/inesita-rb/inesita/compare/v0.3.5...v0.4.0
[0.4.0]: https://github.com/inesita-rb/inesita/compare/v0.3.5...v0.4.0
[0.3.5]: https://github.com/inesita-rb/inesita/compare/v0.3.2...v0.3.5
[0.3.2]: https://github.com/inesita-rb/inesita/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/inesita-rb/inesita/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/inesita-rb/inesita/compare/v0.0.0...v0.3.1
