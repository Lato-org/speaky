require_relative "lib/speaky/version"

Gem::Specification.new do |spec|
  spec.name        = "speaky"
  spec.version     = Speaky::VERSION
  spec.authors     = ["Gregorio Galante"]
  spec.email       = ["me@gregoriogalante.com"]
  spec.homepage    = "https://github.com/GAMS-Software/speaky"
  spec.summary     = "Store activerecord models in vector stores and query them with LLMs!"
  spec.description = "Store activerecord models in vector stores and query them with LLMs!"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/GAMS-Software/speaky"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib}/**/*", "MIT-LICENSE", "README.md"]
  end
end
