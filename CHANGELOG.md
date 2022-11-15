# Changelog
All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

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
