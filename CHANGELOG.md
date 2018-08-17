## [0.8.0] - 17.08.2018

### Changed
- sprockets setup moved from `config.ru` into `.sprockets.rb` file


## [0.7.0] - 22.02.2018

### Fixes
- `thor` warrnings
- 'sprockets' warrnings

### Changed
- Update `opal` to `0.11`
- Move templates configuration to `config.ru`

### Removed
- remove `slim` dependency
- remove `sass` dependency


## [0.6.1] - 2016.11.07

### Added
- `inject` class method for `Component`
- `init` callbacks

### Removed
- `router` - moved to separate gem
- `Store` - use `Injection`
- `Application` - use `Component` and `inject`
- `Layout` - use component instead

## [0.5.1] - 2016.10.29

### Fixes
- Error when router not exists


## [0.5.0] - 2016.10.29

### Added
- Injection (you can inject any object)
- `before_render` callback to `Component`

### Changed
- Store is deprecated, use Injection

### Removed
- `init` callback, use `initialize` instead


## [0.4.4] - 2016.10.04

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

[Unreleased]: https://github.com/inesita-rb/inesita/compare/v0.6.1...HEAD
[0.6.1]: https://github.com/inesita-rb/inesita/compare/v0.5.1...v0.6.1
[0.5.1]: https://github.com/inesita-rb/inesita/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/inesita-rb/inesita/compare/v0.4.1...v0.5.0
[0.4.4]: https://github.com/inesita-rb/inesita/compare/v0.4.1...v0.4.4
[0.4.1]: https://github.com/inesita-rb/inesita/compare/v0.4.0...v0.4.1
[0.4.0]: https://github.com/inesita-rb/inesita/compare/v0.3.5...v0.4.0
[0.4.0]: https://github.com/inesita-rb/inesita/compare/v0.3.5...v0.4.0
[0.3.5]: https://github.com/inesita-rb/inesita/compare/v0.3.2...v0.3.5
[0.3.2]: https://github.com/inesita-rb/inesita/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/inesita-rb/inesita/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/inesita-rb/inesita/compare/v0.0.0...v0.3.1
