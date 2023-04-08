# Changelog
All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## 1.0.1 - 2023-04-07
### Fixed
- Bump the number just to force use of new artifact from Rubygems. I made a mistake publishing the previous version

---
## 1.0.0 - 2023-04-07
### Changed
- `then_if` accept non callable values and interpret them by their truth value
- `then_unless` accept non callable values and interpret them by their truth value
- `complement` will negate the receiver's values directly if it is not a callable

### Removed
- `complement` doesn't rais an ArgumentError when it's receiver was not a callable

---
## 0.1.0 - 2022-11-15
### Added
- Object extensions
	- then_if
		- process the receiver with the given block if condition is true
	- unless_if
		- complement of `then_if`
	- complement
		- produce a proc which is the logical complement of the receiver
	- constantly
		- produce a proc which always returns the receiver

---
