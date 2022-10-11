# frozen_string_literal: true

require_relative "lib/uppy/rails/version"

Gem::Specification.new do |spec|
  spec.name = "uppy-rails"
  spec.version = Uppy::Rails::VERSION
  spec.authors = ["Frank Walentowski"]
  spec.email = ["frank.walentowski@inchron.de"]

  spec.summary = "an asset gemification of uppy"
  spec.description = "Uppy, integrated in Rails assets pipeline."
  spec.homepage = "https://github.com/inchron/uppy-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
