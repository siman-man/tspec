# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "tspec"
  spec.version       = "0.3.0"
  spec.authors       = ["siman-man"]
  spec.email         = ["k128585@ie.u-ryukyu.ac.jp"]

  spec.summary       = %q{Add type check method}
  spec.description   = %q{Add type check method}
  spec.homepage      = "https://github.com/siman-man/tspec"
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "coderay", "~> 1.1"
end
