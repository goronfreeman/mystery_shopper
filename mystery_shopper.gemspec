lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mystery_shopper/version'

Gem::Specification.new do |spec|
  spec.name          = 'mystery_shopper'
  spec.version       = MysteryShopper::VERSION
  spec.authors       = ['Hunter Braun']
  spec.email         = ['hunter.braun@gmail.com']

  spec.summary       = 'TODO: Write a short summary, because RubyGems requires one.'
  spec.description   = 'TODO: Write a longer description or delete this line.'
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.58'
end
