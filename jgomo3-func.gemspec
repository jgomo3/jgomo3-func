require_relative 'lib/jgomo3/func/version'

Gem::Specification.new do |spec|
  spec.name          = "jgomo3-func"
  spec.version       = Jgomo3::Func::VERSION
  spec.authors       = ["Jesús Gómez"]
  spec.email         = ["jgomo3@gmail.com"]

  spec.summary       = 'Library of functions I find useful enough to be included always'
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/jgomo3/jgomo3-func'
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = 'https://github.com/jgomo3/jgomo3-func'
  spec.metadata["changelog_uri"] = 'https://github.com/jgomo3/jgomo3-func/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
