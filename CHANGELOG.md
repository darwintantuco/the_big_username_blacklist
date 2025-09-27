# Changelog

All changes on this project will be documented in this file.

## [1.0.0] - TBD

- **BREAKING CHANGE**: Removed deprecated list-based API (use `extra: [...]` instead)

## [0.2.0] - September 27, 2025

- New keyword options API with `:extra` parameter for extending blacklist
- Global configuration support via `config :the_big_username_blacklist, extra: [...]`
- Deprecation warning for old list-based API (still backwards compatible)
- Runtime options combined with global configuration
- Added input normalization (case-insensitive, whitespace trimming)
- Updated blacklist to v2.0.1 (542 terms, added modern terms like 'graphql', 'paypal', etc.)

## [0.1.2] - March 14, 2020

- Minor improvements on `valid?` function

## [0.1.1] - June 14, 2019

- Ability to extend blacklist

## [0.1.0] - June 8, 2019

- Initial release
