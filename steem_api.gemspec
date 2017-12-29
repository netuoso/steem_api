# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'steem_api/version'

Gem::Specification.new do |spec|
  spec.name          = "steem_api"
  spec.version       = SteemApi::VERSION
  spec.authors       = ["Andrew Chaney (netuoso)"]
  spec.email         = ["andrewc@pobox.com"]

  spec.summary       = %q{Ruby/Rails wrapper for SteemSQL.com}
  spec.description   = %q{Rails compatible gem that provides full DB connection and models to SteemSQL.com}
  spec.homepage      = "https://github.com/netuoso/steem_api"
  spec.license       = "WTFPL"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = "steem_api"
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri", ["~> 1.8"]
  spec.add_runtime_dependency "rest-client", ["~> 2.0"]
  spec.add_runtime_dependency "activerecord", [">= 4", "< 6"]
  spec.add_runtime_dependency "tiny_tds", ["~> 1.3"]
  spec.add_runtime_dependency "activerecord-sqlserver-adapter", [">= 4", "< 6"]
  spec.add_runtime_dependency 'awesome_print', '~> 1.7', '>= 1.7.0'

end
