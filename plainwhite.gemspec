# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "plainwhite"
  spec.version       = "0.13"
  spec.authors       = ["Samarjeet"]
  spec.email         = ["samarsault@gmail.com"]

  spec.summary       = "A portfolio style jekyll theme for writers"
  spec.homepage      = "https://thelehhman.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README|404.html|sitemap.xml|search.json)!i) }

  spec.add_runtime_dependency "jekyll", ">= 4.2.2"
  spec.add_runtime_dependency "jekyll-seo-tag", ">= 2.1.0"

  spec.add_development_dependency "bundler", "> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
end
